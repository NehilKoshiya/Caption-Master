import 'package:get/get.dart';

import '../../../services/ads/ad_service.dart';

class BottomBarController extends GetxController {
  RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
