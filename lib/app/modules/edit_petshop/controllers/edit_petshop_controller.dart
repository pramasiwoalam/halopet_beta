import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EditPetshopController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var paymentType = ''.obs;

  var dropdown = false.obs;

  Future<DocumentSnapshot<Object?>> getPetshop(String petshopId) async {
    DocumentReference petshop = firestore.collection('petshop').doc(petshopId);
    return petshop.get();
  }

  void paymentAccepted(String orderId) {
    DocumentReference docRef = firestore.collection('order').doc(orderId);
    docRef.update({'status': 'On Going'});
    Get.back();
  }
}
