import 'package:get/get.dart';

import '../controllers/medical_list_reg_controller.dart';

class MedicalListRegBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicalListRegController>(
      () => MedicalListRegController(),
    );
  }
}
