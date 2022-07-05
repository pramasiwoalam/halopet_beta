import 'package:get/get.dart';

import '../controllers/medical_list_form_controller.dart';

class MedicalListFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicalListFormController>(
      () => MedicalListFormController(),
    );
  }
}
