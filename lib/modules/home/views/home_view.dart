import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/category_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/ads/ad_service.dart';
import '../../../widgets/app_text.dart';
import '../controllers/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = controller;

    return Scaffold(
      appBar: AppBar(
        title: const AppText("Captions"),
        centerTitle: true,
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       Get.toNamed(AppRoutes.searchScreen);
        //     },
        //     child: Icon(Icons.search, size: 30),
        //   ),
        //   SizedBox(width: 10),
        // ],
      ),

      body: Obx(() {
        if (c.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 16,
          ),
          padding: const EdgeInsets.all(16).copyWith(bottom: 50),
          itemCount: c.categories.length,
          itemBuilder: (context, index) {
            final category = c.categories[index];
            return _buildCategoryCard(category, index, c);
          },
        );
      }),
    );
  }

  // Simplified _buildCategoryCard signature
  Widget _buildCategoryCard(
    CategoryModel category,
    int index,
    HomeController controller,
  ) {
    return InkWell(
      onTap: () {
        controller.showAd.value++;
        if (controller.showAd.value == 3) {
          controller.showAd.value = 0;
          AdService().loadInterstitial();
          AdService().showInterstitial();
        }
        Get.toNamed(AppRoutes.messagesList, arguments: category);
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            // BACKGROUND IMAGE (CACHED)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: category.image,
                  fit: BoxFit.cover,
                  maxHeightDiskCache: 400,
                  maxWidthDiskCache: 400,
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),

            // DARK OVERLAY
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            // CATEGORY NAME
            Positioned(
              left: 16,
              bottom: 16,
              child: SizedBox(
                width: 130,
                child: AppText(
                  category.name,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
