import 'package:get/get.dart';

import '../controllers/edit_petshop_form_controller.dart';

class EditPetshopFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPetshopFormController>(
      () => EditPetshopFormController(),
    );
  }
}
