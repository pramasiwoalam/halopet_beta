import 'package:get/get.dart';

import '../controllers/topup_controller.dart';

class TopUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopUpController>(
      () => TopUpController(),
    );
  }
}
