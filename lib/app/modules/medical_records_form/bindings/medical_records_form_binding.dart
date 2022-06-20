import 'package:get/get.dart';

import '../controllers/medical_records_form_controller.dart';

class MedicalRecordsFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicalRecordsFormController>(
      () => MedicalRecordsFormController(),
    );
  }
}
