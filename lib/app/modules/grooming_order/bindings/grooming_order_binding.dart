import 'package:get/get.dart';

import '../controllers/grooming_order_controller.dart';

class GroomingOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroomingOrderController>(
      () => GroomingOrderController(),
    );
  }
}
