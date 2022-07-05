import 'package:get/get.dart';

import '../controllers/bank_account_reg_controller.dart';

class BankAccountRegBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankAccountRegController>(
      () => BankAccountRegController(),
    );
  }
}
