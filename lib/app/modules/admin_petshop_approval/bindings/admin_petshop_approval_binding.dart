import 'package:get/get.dart';

import '../controllers/admin_petshop_approval_controller.dart';

class AdminPetshopApprovalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminPetshopApprovalController>(
      () => AdminPetshopApprovalController(),
    );
  }
}
