import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/constants/constants.dart';
import '../../../data/models/category_model.dart';
import '../../../services/storage_service.dart';

class MessageListController extends GetxController {
  RxBool loading = false.obs;
  final Random _random = Random();
  final storage = StorageService();
  RxList<String> messages = <String>[].obs;
  RxList<String> likedMessages = <String>[].obs;
  late CategoryModel category;

  List<dynamic> combinedList = [];

  @override
  void onInit() {
    category = Get.arguments as CategoryModel;
    loadMessages();
    loadStoredData();
    buildCombinedList();

    super.onInit();
  }

  // static NativeAd? nativeAd;
  // static bool isNativeAdLoaded = false;
  // RxMap nativeAds = {}.obs;
  // RxMap isAdLoaded = {}.obs;

  // void loadNativeAd(int index) {
  //   nativeAd = NativeAd(
  //     adUnitId: "ca-app-pub-3940256099942544/2247696110", // TEST ID
  //     listener: NativeAdListener(
  //       onAdLoaded: (ad) {
  //         print("Native Ad Loaded");
  //         isNativeAdLoaded = true;
  //         isAdLoaded.value[index] = true;
  //         update();
  //       },
  //       onAdFailedToLoad: (ad, error) {
  //         print("Native Ad Failed: $error");
  //         isNativeAdLoaded = false;
  //         // ad.dispose();
  //
  //         // Retry
  //         loadNativeAd(index);
  //         update();
  //       },
  //     ),
  //     request: const AdRequest(),
  //     nativeTemplateStyle: NativeTemplateStyle(
  //       templateType: TemplateType.medium, // small/medium
  //     ),
  //   );
  //   nativeAds.value[index] = nativeAd!;
  //   update();
  //   nativeAd!.load();
  // }


  void buildCombinedList() {
    combinedList.clear();

    for (int i = 0; i < messages.length; i++) {
      combinedList.add(messages[i]);

      // Insert ad after every 4 messages
      if ((i + 1) % 4 == 0) {
        combinedList.add("AD");
      }
    }
  }

  void loadMessages() {
    loading.value = true;
    var tempMessages = category.messages;
    tempMessages.shuffle();
    messages.assignAll(tempMessages);
    loading.value = false;
  }

  void loadStoredData() {
    likedMessages.value =
    List<String>.from(storage.read<List>(Constants.likedMessages) ?? []);
  }

  // LIKE
  void toggleLike(String message) {
    if (likedMessages.contains(message)) {
      likedMessages.remove(message);
    } else {
      likedMessages.add(message);
    }
    List data = storage.read(Constants.likedMessages);
    data.add(message);
    storage.write(Constants.likedMessages, data);
    loadStoredData();
    update();
  }

  String getRandomImage() {
    final images = Constants().imageList;
    return images[_random.nextInt(images.length)];
  }

  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar("Copied", "Message copied!");
  }
}
