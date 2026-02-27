import 'dart:math' hide log;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/constants.dart';
import '../generated/assets.dart';
import '../services/storage_service.dart';
import 'app_text.dart';

class MessageCardWidget extends StatelessWidget {
  final String text;
  final GlobalKey exportKey;

  const MessageCardWidget({
    super.key,
    required this.text,
    required this.exportKey,
  });

  @override
  Widget build(BuildContext context) {
    final randomImage =
        Constants().imageList[Random().nextInt(Constants().imageList.length)];
    List data = StorageService().read(Constants.likedMessages) ?? [];
    RxBool isLiked = data.contains(text).obs;
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // IMAGE + TEXT
          RepaintBoundary(
            key: exportKey,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(22),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                  ),
                  // Image
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(22),
                  //   child: CachedNetworkImage(
                  //     imageUrl: randomImage,
                  //     height: 260,
                  //     width: double.infinity,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),

                  // Shadow Layer
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // TEXT LAYER
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: AppText(
                                text,
                                fontSize: 20,
                                color: Colors.white,
                                height: 1.3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _iconButton(
                  isLiked.value ? Icons.favorite : Icons.favorite_border,
                  "Like",
                  onTap: () {
                    Constants().toggleLike(text);
                    isLiked.value = data.contains(text);
                  },
                  color: isLiked.value ? Colors.red : Colors.grey,
                ),
                _iconButton(
                  Icons.copy,
                  "Copy",
                  onTap: () {
                    Constants().copyText(text);
                  },
                ),
                _iconButton(
                  Icons.share,
                  widget: Image.asset(Assets.imagesWhatsapp, height: 23),
                  "Share",
                  onTap: () async {
                    Constants().shareToWhatsApp(text, exportKey);
                  },
                ),
                _iconButton(
                  Icons.share,
                  "Share",
                  onTap: () {
                    Constants().exportAndShare(text, context, exportKey);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _iconButton(
    IconData icon,
    String label, {
    Color color = Colors.grey,
    required VoidCallback onTap,
    Widget? widget,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          widget ?? Icon(icon, color: color),
          AppText(label, fontSize: 12,),
        ],
      ),
    );
  }
}
