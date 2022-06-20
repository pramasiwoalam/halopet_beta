import 'package:get/get.dart';

import '../controllers/medical__records_list_controller.dart';

class MedicalRecordsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicalRecordsListController>(
      () => MedicalRecordsListController(),
    );
  }
}
