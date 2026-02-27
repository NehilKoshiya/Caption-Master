import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';

class FeedController extends GetxController {
  HomeController homeController = Get.find();
  var categories = [].obs;

  @override
  void onInit() {
    getAllMessages();
    super.onInit();
  }

  List<String> getAllMessages() {
    List<String> all = [];

    for (var category in homeController.categories) {
      all.addAll(category.messages);
    }

    all.shuffle();
    if(categories.value.isEmpty) {
      categories.value = all;
    }
    update();
    return all;
  }
}
