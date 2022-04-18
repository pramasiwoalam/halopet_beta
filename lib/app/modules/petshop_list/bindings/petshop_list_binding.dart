import 'package:get/get.dart';

import '../controllers/petshop_list_controller.dart';

class PetshopListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetshopListController>(
      () => PetshopListController(),
    );
  }
}
