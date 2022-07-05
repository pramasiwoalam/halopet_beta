import 'package:get/get.dart';

import '../controllers/explore_service_controller.dart';

class ExploreServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExploreServiceController>(
      () => ExploreServiceController(),
    );
  }
}
