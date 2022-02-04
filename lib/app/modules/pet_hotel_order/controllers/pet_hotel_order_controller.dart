import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/petshop_detail/controllers/petshop_detail_controller.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

class PetHotelOrderController extends GetxController {
  var date = "null".obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final localStorage = GetStorage();
  final detailC = Get.put(PetshopDetailController());

  void createOrder(String petType, String date) {
    CollectionReference order = firestore.collection("order");

    try {
      // order.add({
      //   "bookingType": "Pet Hotel",
      //   "petType": petType,
      //   "orderDate": date,
      //   "userId": localStorage.read('currentUserId'),
      //   "petshopId": localStorage.read('petshopId'),
      //   "status": "Waiting for approval"
      // });

      detailC.orderList.add({'serviceName': 'Pet Hotel', 'price': 20000.obs});
      // localStorage.write('orderList', detailC.orderList);

      Get.toNamed(Routes.CART_PAGE);
    } catch (e) {
      print(e);
    }
  }
}
