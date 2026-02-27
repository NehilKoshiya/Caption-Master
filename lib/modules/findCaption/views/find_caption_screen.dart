import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_caption/core/constants/app_colors.dart';
import 'package:post_caption/routes/app_routes.dart';
import '../../../generated/assets.dart';
import '../../../widgets/app_text.dart';
import '../controllers/find_caption_controller.dart';

class FindCaptionScreen extends StatelessWidget {
  FindCaptionScreen({super.key});

 final FindCaptionController controller = Get.put(FindCaptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Illustration top right
            Positioned(
              top: 0,
              right: 0,
              child: Opacity(
                opacity: 0.90,
                child: Image.asset(Assets.imagesFindImage1, height: 160),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),

                  // Icon + text caption
                  SizedBox(
                    width: 280,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.pink.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite,
                            size: 26,
                            color: Colors.pink,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: "Find suitable ",
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.4,
                                color: TextTheme.of(context).bodyLarge?.color,
                              ),
                              children: [
                                TextSpan(
                                  text: "Caption",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: " for a picture."),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 70),

                  Center(
                    child: Obx(() {
                      final selected = controller.selectedImage.value;

                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          selected != null
                              ? Container(
                                  height: 340,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.file(
                                      selected,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Opacity(
                                  opacity: 0.25,
                                  child: Image.asset(
                                    Assets.imagesNoImage1,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          if (selected != null)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: InkWell(
                                onTap: () {
                                  controller.clearImage();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.withAlpha(150),
                                  ),
                                  child: Icon(Icons.close, color: Colors.white),
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                  Spacer(),
                  const Center(
                    child: AppText(
                      "Upload image and find a matching caption instantly 😍",
                      textAlign: TextAlign.center,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 30),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        if (controller.selectedImage.value == null) {
                          controller.pickImage();
                        } else {
                          Get.toNamed(AppRoutes.getCaptionsView);
                        }
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.neonPink,
                        ),
                        child: Center(
                          child: AppText(
                            controller.selectedImage.value == null
                                ? "Upload Image"
                                : "Get Captions",
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
