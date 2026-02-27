import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../generated/assets.dart';
import '../../../widgets/message_card.dart';
import '../controllers/search_controller.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});

  SearchCaptionController controller = Get.put(SearchCaptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: TextField(
          onChanged: controller.search,
          decoration: const InputDecoration(
            hintText: "Search captions",
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,)),
            contentPadding: EdgeInsets.symmetric(horizontal: 4)
          ),
        ),
      ),
      body: Obx(() {
        if (controller.query.isEmpty) {
          return  Center(
            child: Opacity(
              opacity: 0.90,
              child: Image.asset(Assets.imagesFindImage1, height: 160),
            ),
          );
        }

        if (controller.results.isEmpty) {
          return const Center(
            child: Text(
              "No results found",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.results.length,
          itemBuilder: (context, index) {
            final item = controller.results[index];
            final captions = item["caption"] as List;

            return Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                // color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["title"],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      captions.length,
                          (i) {
                            final exportKey = GlobalKey();
                            return MessageCardWidget(
                              text: captions[i],
                              exportKey: exportKey,
                            );
                          },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}