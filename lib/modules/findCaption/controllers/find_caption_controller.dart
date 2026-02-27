import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FindCaptionController extends GetxController {
  final ImagePicker picker = ImagePicker();

  Rx<File?> selectedImage = Rx<File?>(null);

  /// Pick image from gallery
  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  /// Remove image if needed
  void clearImage() {
    selectedImage.value = null;
  }
}
