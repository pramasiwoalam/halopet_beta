import 'package:get/get.dart';

import '../controllers/medical_list_controller.dart';

class MedicalListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicalListController>(
      () => MedicalListController(),
    );
  }
}
