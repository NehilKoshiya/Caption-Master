import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../core/constants/constants.dart';
import '../../../generated/assets.dart';
import '../../../services/ads/ad_service.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/message_card.dart';
import '../controllers/messages_controller.dart';

class MessageListView extends GetView<MessageListController> {
  const MessageListView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = controller;

    return Scaffold(
      appBar: AppBar(title: AppText(c.category.name), centerTitle: true),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Obx(() {
          if (c.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              buildNativeAd(),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(5),
                // itemCount: c.messages.length + 1,
                itemCount: c.messages.length,
                itemBuilder: (context, index) {
                  // final bgImage = c.getRandomImage();
                  final exportKey = GlobalKey();

                  // Show ad only at position 2 (after 2 messages)
                  // if (index == 2) {
                    // return buildNativeAd();
                  // }

                  // Fix message index after inserting ad at index 2
                  // int messageIndex = index;
                  // if (index > 2) {
                  //   messageIndex = index - 1;
                  // }

                  return  Padding(
                    padding: const EdgeInsets.all(11),
                    child: MessageCardWidget(
                      // text: c.messages[messageIndex],
                      text: c.messages[index],
                      exportKey: exportKey,
                    ),
                  );
                  // return _buildMessageCard(
                  //   text: c.messages[index],
                  //   image: bgImage,
                  //   c: c,
                  //   context: context,
                  //   exportKey: exportKey,
                  // );
                },
              ),
            ],
          );


          //   ListView.builder(
          //   physics: NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   padding: const EdgeInsets.all(16),
          //     itemCount: c.messages.length + (c.messages.length ~/ 4),
          //   itemBuilder: (context, index) {
          //     // final bgImage = c.getRandomImage();
          //     final exportKey = GlobalKey();
          //
          //     // Show ad at every 5th position → (index + 1) % 5 == 0
          //     if ((index + 1) % 5 == 0) {
          //       return buildNativeAd();
          //       return SizedBox();
          //     }
          //
          //     // Calculate the actual message index
          //     final messageIndex = index - (index ~/ 5);
          //
          //    return  MessageCardWidget(
          //       text: c.messages[messageIndex],
          //       exportKey: exportKey,
          //     );
          //     // return _buildMessageCard(
          //     //   text: c.messages[index],
          //     //   image: bgImage,
          //     //   c: c,
          //     //   context: context,
          //     //   exportKey: exportKey,
          //     // );
          //   },
          // );
        }),
      ),
    );
  }

  Widget buildNativeAd() {
    // AdService.loadNativeAd();
    return Obx(() {
      if (AdService.isNativeAdLoaded.value && AdService.nativeAd != null) {
        return SizedBox(height: 400, child: AdWidget(ad: AdService.nativeAd!));
      } else {
        return SizedBox.shrink();
      }
    });
  }



  Widget _buildMessageCard({
    required String text,
    required String image,
    required BuildContext context,
    required MessageListController c,
    required final GlobalKey exportKey,
  }) {
    RxBool isLiked = c.likedMessages.contains(text).obs;
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
          RepaintBoundary(
            key: exportKey,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(22),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      height: 260,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (c, _) =>
                          Container(height: 260, color: Colors.black12),
                      errorWidget: (c, _, __) => Container(
                        height: 260,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.broken_image, size: 40),
                      ),
                    ),
                  ),

                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),

                  // TEXT AREA
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "“",
                            style: TextStyle(fontSize: 50, color: Colors.white),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: AppText(
                                text,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                height: 1.3,
                                color: Colors.white
                              ),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "”",
                              style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
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
                  color: isLiked.value ? Colors.red : Colors.grey,
                  onTap: () {
                    c.toggleLike(text);
                    isLiked.value = c.likedMessages.contains(text);
                  },
                ),
                _iconButton(Icons.copy, "Copy", onTap: () => c.copyText(text)),
                _iconButton(
                  Icons.share,
                  widget: Image.asset(Assets.imagesWhatsapp, height: 25),
                  "Share",
                  onTap: () async {
                    try {

                    } catch (e) {
                      rethrow;
                    }
                  },
                ),
                _iconButton(
                  Icons.share,
                  "Share",
                  onTap: () => Constants().exportAndShare(text,context, exportKey),
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
    VoidCallback? onTap,
    Widget? widget,
    Color color = Colors.grey,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          widget ?? Icon(icon, color: color),
          const SizedBox(height: 3),
          AppText(label, fontSize: 12, color: Colors.grey),
        ],
      ),
    );
  }
}

//
// class MessageListView extends GetView<MessageListController> {
//   const MessageListView({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     final c = controller;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(c.category.name),
//         centerTitle: true,
//       ),
//       body: Obx(() {
//         if (c.loading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: c.messages.length,
//           itemBuilder: (context, index) {
//             return _buildMessageCard(c.messages[index],c);
//           },
//         );
//       }),
//     );
//   }
//
//   Widget _buildMessageCard(String text, MessageListController c) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       padding: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(22),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           )
//         ],
//       ),
//       child: Column(
//         children: [
//           // GRADIENT MESSAGE CARD
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(22),
//               gradient: const LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xffd6249f),
//                   Color(0xff8b0fa8),
//                   Color(0xff000000),
//                 ],
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "“",
//                   style: TextStyle(fontSize: 50, color: Colors.white),
//                 ),
//                 Text(
//                   text,
//                   style: const TextStyle(
//                     fontSize: 22,
//                     color: Colors.white,
//                     height: 1.3,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     "”",
//                     style: TextStyle(fontSize: 50, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 10),
//
//           // ACTION BUTTONS
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _iconButton(Icons.favorite_border, "Like"),
//               _iconButton(Icons.bookmark_border, "Save"),
//               _iconButton(Icons.copy, "Copy", onTap: () => c.copyText(text)),
//               _iconButton(Icons.share, "Share", onTap: () => c.shareText(text)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _iconButton(IconData icon, String label, {VoidCallback? onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Icon(icon, color: Colors.black87),
//           const SizedBox(height: 3),
//           Text(label, style: const TextStyle(fontSize: 12)),
//         ],
//       ),
//     );
//   }
// }
