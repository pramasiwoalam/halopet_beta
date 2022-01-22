import 'package:get/get.dart';

import '../controllers/add_petshop_controller.dart';

class AddPetshopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPetshopController>(
      () => AddPetshopController(),
    );
  }
}
