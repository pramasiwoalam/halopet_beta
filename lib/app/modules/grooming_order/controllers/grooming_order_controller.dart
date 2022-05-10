import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

class GroomingOrderController extends GetxController {
  var date = "null".obs;
  var packageFlag = 'null'.obs;

  var packageName = 'null'.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final localStorage = GetStorage();

  Future<DocumentSnapshot<Object?>> getPets(String petId) async {
    DocumentReference doc = firestore.collection("pets").doc(petId);
    return doc.get();
  }

  void createOrder(String petType, String date) {
    CollectionReference order = firestore.collection("order");

    try {
      order.add({
        "bookingType": "Grooming",
        "petType": petType,
        "orderDate": date,
        "userId": localStorage.read('currentUserId'),
        "petshopId": localStorage.read('petshopId'),
        "status": "Waiting for approval",
        "message": ""
      });
      Get.toNamed(Routes.ORDER);
    } catch (e) {
      print(e);
    }
  }
}
