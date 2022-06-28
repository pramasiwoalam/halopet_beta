import 'package:get/get.dart';

import '../controllers/edit_petshop_controller.dart';

class EditPetshopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPetshopController>(
      () => EditPetshopController(),
    );
  }
}
