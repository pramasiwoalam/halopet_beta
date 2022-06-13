import 'package:get/get.dart';

import '../controllers/choose_room_controller.dart';

class ChooseRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseRoomController>(
      () => ChooseRoomController(),
    );
  }
}
