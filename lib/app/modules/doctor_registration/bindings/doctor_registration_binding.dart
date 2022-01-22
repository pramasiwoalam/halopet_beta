import 'package:get/get.dart';

import '../controllers/doctor_registration_controller.dart';

class DoctorRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorRegistrationController>(
      () => DoctorRegistrationController(),
    );
  }
}
