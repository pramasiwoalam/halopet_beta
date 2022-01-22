import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SellerProfileController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getUser(String userId) async {
    DocumentReference doc = firestore.collection("users").doc(userId);
    return doc.get();
  }

  Future<DocumentSnapshot<Object?>> getPetshopDetail(String petshopId) async {
    DocumentReference doc = firestore.collection('petshop').doc(petshopId);
    return doc.get();
  }
}
