import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminPetshopApprovalController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getPetshop(String petshopId) async {
    DocumentReference doc = firestore.collection("petshop").doc(petshopId);
    return doc.get();
  }

  void accept(String petshopId, String petshopOwnerId) {
    DocumentReference docRef = firestore.collection('petshop').doc(petshopId);
    DocumentReference docRefRole =
        firestore.collection('users').doc(petshopOwnerId);
    docRefRole.update({'role': 'Seller', 'petshopOwner': true});
    docRef.update({'status': 'Approved'});
    Get.back();
    Get.back();
  }

  void decline(String petshopId) {
    DocumentReference docRef = firestore.collection('petshop').doc(petshopId);
    docRef.update({'status': 'Approved'});
    Get.back();
    Get.back();
  }
}
