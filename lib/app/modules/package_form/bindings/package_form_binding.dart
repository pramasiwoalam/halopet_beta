import 'package:get/get.dart';

import '../controllers/package_form_controller.dart';

class PackageFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PackageFormController>(
      () => PackageFormController(),
    );
  }
}
