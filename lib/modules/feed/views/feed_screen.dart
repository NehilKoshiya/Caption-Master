import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/message_card.dart';
import '../controllers/feed_controller.dart';

class FeedView extends GetView<FeedController> {
  FeedView({super.key});

  FeedController feedController = FeedController().initialized
      ? Get.find()
      : Get.put(FeedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText("Feed"),
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
      body: ListView.builder(
        padding: EdgeInsets.all(14),
        itemCount: feedController.getAllMessages().length,
        itemBuilder: (context, index) {
          final exportKey = GlobalKey();
          return MessageCardWidget(
            text: feedController.categories[index],
            exportKey: exportKey,
          );
        },
      ),
    );
  }
}
