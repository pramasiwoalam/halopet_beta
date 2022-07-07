import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EditPetshopController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var paymentType = ''.obs;

  var dropdown = false.obs;

  var isOpen = true.obs;

  Future<DocumentSnapshot<Object?>> getPetshop(String petshopId) async {
    DocumentReference petshop = firestore.collection('petshop').doc(petshopId);
    return petshop.get();
  }

  void updateIsOpen(bool status, String petshopId) {
    DocumentReference docRef = firestore.collection('petshop').doc(petshopId);
    docRef.update({'isOpen': status});
  }
}
