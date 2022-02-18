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

  Future<Object?> createOrder(String petType, String date) async {
    CollectionReference order = firestore.collection("order");

    try {
      order.add({
        "bookingType": "Pet Hotel",
        "petType": petType,
        "orderDate": date,
        "userId": localStorage.read('currentUserId'),
        "petshopId": localStorage.read('petshopId'),
        "status": "Waiting for approval"
      });
      return 'Order Success';
    } catch (e) {
      return 'Error';
    }
  }
}
