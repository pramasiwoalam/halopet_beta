import 'package:get/get.dart';

import '../controllers/session_detail_controller.dart';

class SessionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SessionDetailController>(
      () => SessionDetailController(),
    );
  }
}
