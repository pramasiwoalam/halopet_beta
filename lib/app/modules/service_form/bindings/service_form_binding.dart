import 'package:get/get.dart';

import '../controllers/service_form_controller.dart';

class ServiceFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceFormController>(
      () => ServiceFormController(),
    );
  }
}
