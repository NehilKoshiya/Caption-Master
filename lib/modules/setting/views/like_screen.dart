import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_text.dart';
import '../../../widgets/message_card.dart';
import '../controllers/setting_controller.dart';


class LikedMessagesView extends StatefulWidget {
  const LikedMessagesView({super.key});

  @override
  State<LikedMessagesView> createState() => _LikedMessagesViewState();
}

class _LikedMessagesViewState extends State<LikedMessagesView> {
  final SettingController c = Get.find();

  @override
  void initState() {
    c.loadStoredData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppText("Liked Messages"), centerTitle: true),
      body: Obx(() {
        if (c.likedMessages.isEmpty) {
          return Center(child: AppText("No liked messages"));
        }

        return ListView.builder(
          padding: EdgeInsets.all(14),
          itemCount: c.likedMessages.length,
          itemBuilder: (context, index) {
            final exportKey = GlobalKey();
            return MessageCardWidget(
              text: c.likedMessages[index],
              exportKey: exportKey,
            );
          },
        );
      }),
    );
  }
}
