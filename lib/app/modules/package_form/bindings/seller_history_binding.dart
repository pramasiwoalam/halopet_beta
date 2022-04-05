import 'package:get/get.dart';

import '../controllers/seller_history_controller.dart';

class SellerHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerHistoryController>(
      () => SellerHistoryController(),
    );
  }
}
