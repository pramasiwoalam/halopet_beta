import 'package:get/get.dart';

import '../controllers/choose_pet_controller.dart';

class ChoosePetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChoosePetController>(
      () => ChoosePetController(),
    );
  }
}
