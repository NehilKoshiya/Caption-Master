import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_text.dart';
import '../../../widgets/message_card.dart';
import '../controllers/find_caption_controller.dart';

class GetCaptionsView extends GetView<FindCaptionController> {
  const GetCaptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppText("Generated Captions"), centerTitle: true),
      body: ListView.builder(
        padding: EdgeInsets.all(14),
        itemCount: 5,
        itemBuilder: (context, index) {
          final exportKey = GlobalKey();
          return MessageCardWidget(
            text: "Test",
            exportKey: exportKey,
          );
        },
      ),
    );
  }}