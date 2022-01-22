import 'package:get/get.dart';

import '../controllers/petshop_detail_controller.dart';

class PetshopDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetshopDetailController>(
      () => PetshopDetailController(),
    );
  }
}
