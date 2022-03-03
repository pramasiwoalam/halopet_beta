import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<DocumentSnapshot<Object?>> getUser(String userId) async {
    DocumentReference doc = firestore.collection("users").doc(userId);
    return doc.get();
  }

  Future<DocumentSnapshot<Object?>> getPetshopDetail(String petshopId) async {
    DocumentReference doc = firestore.collection('petshop').doc(petshopId);
    return doc.get();
  }

  void changeRoleToMember(String userId) {
    Future<void> users =
        firestore.collection('users').doc(userId).update({"role": "Member"});
    auth.currentUser!.reload();
    Get.back();
  }

  void changeRoleToSeller(String userId) {
    Future<void> users =
        firestore.collection('users').doc(userId).update({"role": "Seller"});
    auth.currentUser!.reload();
  }
}
