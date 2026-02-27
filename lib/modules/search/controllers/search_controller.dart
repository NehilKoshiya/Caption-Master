import 'package:get/get.dart';
import 'package:post_caption/modules/home/controllers/home_controller.dart';

class SearchCaptionController extends GetxController {
  HomeController homeController = Get.find();
  var query = ''.obs;
  var results = <Map<String, dynamic>>[].obs;



  /// Simplified list for searching
  final List<Map<String, dynamic>> allCaptions = <Map<String, dynamic>>[];


  @override
  void onInit() {
    super.onInit();


    /// Convert CategoryModel list to simple search map
    _updateSearchList();


    /// Automatically update search list when categories list changes
    ever(homeController.categories, (_) => _updateSearchList());
  }


  void _updateSearchList() {
    allCaptions.clear();
    for (var cat in homeController.categories) {
      allCaptions.add({
        "name": cat.name,
        "captions": cat.messages,
      });
    }
  }

  void search(String text) {
    query.value = text;


    if (text.isEmpty) {
      results.clear();
      return;
    }


    final lowerText = text.toLowerCase();


    results.value = allCaptions.map((item) {
      final title = item["name"].toString().toLowerCase();
      final captions = (item["captions"] as List).map((c) => c.toString()).toList();


// Filter captions that contain the search text
      final matchedCaptions = captions.where((cap) => cap.toLowerCase().contains(lowerText)).toList();


      if (title.contains(lowerText) || matchedCaptions.isNotEmpty) {
        return {
          "title": item["name"],
          "caption": matchedCaptions.isNotEmpty ? matchedCaptions : captions,
        };
      } else {
        return null;
      }
    }).where((e) => e != null).toList().cast<Map<String, dynamic>>();
  }


  // void search(String text) {
  //   query.value = text;
  //
  //
  //   if (text.isEmpty) {
  //     results.clear();
  //     return;
  //   }
  //
  //
  //   results.value = allCaptions.where((item) {
  //     final title = item["name"].toString().toLowerCase();
  //     final captions = (item["captions"] as List)
  //         .map((c) => c.toString().toLowerCase())
  //         .toList();
  //
  //
  //     return title.contains(text.toLowerCase()) ||
  //         captions.any((cap) => cap.contains(text.toLowerCase()));
  //   }).map((e) => {
  //     "title": e["name"],
  //     "caption": e["captions"],
  //   }).toList();
  // }
}
