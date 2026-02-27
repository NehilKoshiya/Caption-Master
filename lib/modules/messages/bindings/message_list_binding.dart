import 'package:get/get.dart';

import '../controllers/messages_controller.dart';

class MessageListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageListController>(() => MessageListController());
  }
}
