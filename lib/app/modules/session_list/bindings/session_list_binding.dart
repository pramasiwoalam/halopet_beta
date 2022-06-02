import 'package:get/get.dart';

import '../controllers/session_list_controller.dart';

class SessionListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SessionListController>(
      () => SessionListController(),
    );
  }
}
