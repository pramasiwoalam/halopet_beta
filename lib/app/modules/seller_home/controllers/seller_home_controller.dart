import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SellerHomeController extends GetxController {
  var index = 0.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference order = firestore.collection("order");
    return order.snapshots();
  }

  Future<DocumentSnapshot<Object?>> getPetshopId(String petshopId) {
    DocumentReference doc = firestore.collection('petshop').doc(petshopId);
    return doc.get();
  }

  @override
  void onInit() {
    index = 0.obs;
  }
}
