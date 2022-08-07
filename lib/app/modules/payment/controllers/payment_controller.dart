import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var paymentType = 'ewallet'.obs;

  Future<DocumentSnapshot<Object?>> getOrder(String orderId) async {
    DocumentReference doc = firestore.collection("order").doc(orderId);
    return doc.get();
  }

  Future<DocumentSnapshot<Object?>> getUser(String userId) async {
    DocumentReference doc = firestore.collection("users").doc(userId);
    return doc.get();
  }

  void paymentAccepted(String orderId) {
    DocumentReference docRef = firestore.collection('order').doc(orderId);

    docRef.update({'status': 'On Going'});
    Get.back();
  }
}
