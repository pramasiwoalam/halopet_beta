import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerOrderDetailController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isDeclined = false.obs;
  final messageC = TextEditingController();

  Future<DocumentSnapshot<Object?>> getOrder(String orderId) async {
    DocumentReference doc = firestore.collection("order").doc(orderId);
    return doc.get();
  }

  void accepted(String orderId) {
    DocumentReference docRef = firestore.collection('order').doc(orderId);

    docRef.update({'status': 'Waiting for payment'});
    Get.back();
  }

  void declined(String orderId, String message) {
    DocumentReference docRef = firestore.collection('order').doc(orderId);

    docRef.update({"status": 'Declined', "message": message});
    Get.back();
    Get.back();
  }
}
