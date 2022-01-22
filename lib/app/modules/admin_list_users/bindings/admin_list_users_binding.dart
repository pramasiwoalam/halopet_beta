import 'package:get/get.dart';

import '../controllers/admin_list_users_controller.dart';

class AdminListUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminListUsersController>(
      () => AdminListUsersController(),
    );
  }
}
