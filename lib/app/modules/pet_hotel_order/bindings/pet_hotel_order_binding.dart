import 'package:get/get.dart';

import '../controllers/pet_hotel_order_controller.dart';

class PetHotelOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetHotelOrderController>(
      () => PetHotelOrderController(),
    );
  }
}
