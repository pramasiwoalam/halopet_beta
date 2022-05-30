import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DeliveryListController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final localStorage = GetStorage();
  var time = "null".obs;
  var status = '0'.obs;
  double deliveryFee = 0;

  Future<DocumentSnapshot<Object?>> getUser(String userId) {
    DocumentReference doc = firestore.collection("users").doc(userId);
    return doc.get();
  }

  Future<DocumentSnapshot<Object?>> getPackage(String packageId) async {
    DocumentReference doc = firestore.collection("package").doc(packageId);
    return doc.get();
  }
}
