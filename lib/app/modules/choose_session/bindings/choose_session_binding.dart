import 'package:get/get.dart';

import '../controllers/choose_session_controller.dart';

class ChooseSessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseSessionController>(
      () => ChooseSessionController(),
    );
  }
}
