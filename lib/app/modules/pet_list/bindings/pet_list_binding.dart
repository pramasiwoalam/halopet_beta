import 'package:get/get.dart';

import '../controllers/pet_list_controller.dart';

class PetListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetListController>(
      () => PetListController(),
    );
  }
}
