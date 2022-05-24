import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

class GroomingOrderController extends GetxController {
  var date = "null".obs;
  var packageFlag = 'null'.obs;

  var packageName = 'null';
  var packageData = GetStorage().read('packageData');
  var status = '0';

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getPets(String petId) async {
    DocumentReference doc = firestore.collection("pets").doc(petId);
    return doc.get();
  }

  Future<DocumentSnapshot<Object?>> getPackage(String packageId) async {
    DocumentReference doc = firestore.collection("package").doc(packageId);
    return doc.get();
  }

  void createOrder(String petId, String date, String packageId,
      String serviceType, double charge) {
    final localStorage = GetStorage();
    CollectionReference order = firestore.collection("order");

    try {
      order.add({
        "bookingType": "Grooming",
        "petId": localStorage.read('petId'),
        "orderCreated":
            formatDate(DateTime.now(), [MM, ' ', dd, ',', ' ', yyyy]),
        "orderDate": date,
        "userId": localStorage.read('currentUserId'),
        "petshopId": localStorage.read('petshopId'),
        "status": "Waiting for approval",
        "message": "",
        "packageId": packageId,
        "serviceType": serviceType,
        "charge": charge
      });
      Get.toNamed(Routes.HOMEPAGE);
    } catch (e) {
      print(e);
    }
  }
}
