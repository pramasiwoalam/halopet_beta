import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PetshopDetailController extends GetxController {
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getPetshopDetail(String petshopId) async {
    DocumentReference doc = firestore.collection("petshop").doc(petshopId);
    return doc.get();
  }

}
