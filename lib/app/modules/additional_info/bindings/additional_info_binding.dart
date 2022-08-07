import 'package:get/get.dart';
import 'package:halopet_beta/app/modules/add_petshop/controllers/add_petshop_controller.dart';

class AdditionalInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPetshopController>(
      () => AddPetshopController(),
    );
  }
}
