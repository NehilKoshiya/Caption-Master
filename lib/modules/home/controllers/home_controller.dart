import 'package:get/get.dart';

import '../../../data/models/category_model.dart';
import '../../../services/static_data_service.dart';

class HomeController extends GetxController {
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxBool loading = true.obs;
  RxInt showAd = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  Future<void> loadCategories() async {
    loading.value = true;

    final data = await StaticDataService.instance.loadMessages();
    categories.value = data.categories;
    categories.value.shuffle();
    loading.value = false;
    update();
  }
}
