import 'package:get/get.dart';
import 'package:post_caption/modules/findCaption/controllers/find_caption_controller.dart';

class FindCaptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindCaptionController>(() => FindCaptionController());
  }
}
