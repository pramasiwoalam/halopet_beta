import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
    CollectionReference notification = firestore.collection("notification");
    final format = DateFormat('MMMM dd');
    final date = format.format(DateTime.now());

    docRef.update({'status': 'Waiting for payment'});
    notification.add({
      'title': 'Booking Approved.',
      'message':
          'Your booking has been approved by petshop. You can check the status at order list.',
      'dateCreated': date,
      'isOpened': false
    });
    print(date);
    Get.back();
  }

  void declined(String orderId, String message) {
    DocumentReference docRef = firestore.collection('order').doc(orderId);

    docRef.update({"status": 'Declined', "message": message});
    Get.back();
    Get.back();
  }

  void bookingCancellation(String orderId, String message) {
    DocumentReference docRef = firestore.collection('order').doc(orderId);

    docRef.update({'status': 'Cancelled', 'cancellationReason': message});
    Get.back();
  }
}
