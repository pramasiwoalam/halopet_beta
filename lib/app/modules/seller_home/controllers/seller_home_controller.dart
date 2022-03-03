import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SellerHomeController extends GetxController {
  var index = 0.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var localStorage = GetStorage();

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference order = firestore.collection("order");
    return order.snapshots();
  }

  Future<DocumentSnapshot<Object?>> getUser(String userId) async {
    DocumentReference doc = firestore.collection("users").doc(userId);
    return doc.get();
  }

  Stream<QuerySnapshot<Object?>> getByApprovalStatus(String petshopId) {
    print(petshopId);
    CollectionReference order = firestore.collection("order");
    return order
        .where('petshopId', isEqualTo: petshopId)
        .where('status', isEqualTo: 'Waiting for approval')
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>> getByPaymentStatus(String petshopId) {
    CollectionReference order = firestore.collection("order");
    return order
        .where('petshopId', isEqualTo: petshopId)
        .where('status', isEqualTo: 'Waiting for payment')
        .snapshots();
  }
}
