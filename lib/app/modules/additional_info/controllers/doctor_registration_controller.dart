import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdditionalInfoController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getUser(String userId) async {
    DocumentReference doc = firestore.collection("users").doc(userId);
    return doc.get();
  }

  Future<DocumentSnapshot<Object?>> getPet(String petId) async {
    DocumentReference doc = firestore.collection("pets").doc(petId);
    return doc.get();
  }
}
