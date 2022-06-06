import 'package:get/get.dart';

import '../controllers/choose_date_controller.dart';

class ChooseDateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseDateController>(
      () => ChooseDateController(),
    );
  }
}
