import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getOrder(String orderId) async {
    DocumentReference doc = firestore.collection("order").doc(orderId);
    return doc.get();
  }

  Future<DocumentSnapshot<Object?>> getPackage(String packageId) async {
    DocumentReference doc = firestore.collection("package").doc(packageId);
    return doc.get();
  }

  Future<DocumentSnapshot<Object?>> getPetshopByOrder(String petshopId) async {
    print(petshopId);
    DocumentReference doc = firestore.collection("petshop").doc(petshopId);
    return doc.get();
  }

  void bookingCancellation(String orderId, String message) {
    DocumentReference docRef = firestore.collection('order').doc(orderId);

    docRef.update({'status': 'Cancelled', 'cancellationReason': message});
    Get.back();
  }
}
