import 'package:get/get.dart';

import '../controllers/edit_package_controller.dart';

class EditPackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPackageController>(
      () => EditPackageController(),
    );
  }
}
