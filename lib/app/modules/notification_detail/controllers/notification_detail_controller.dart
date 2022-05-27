import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationDetailController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isDeclined = false.obs;
  final messageC = TextEditingController();

  Future<DocumentSnapshot<Object?>> getNotification(
      String notificationId) async {
    DocumentReference doc =
        firestore.collection("notification").doc(notificationId);
    return doc.get();
  }
}
