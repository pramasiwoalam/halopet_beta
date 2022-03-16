import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RatingController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  double rating = 0;
  var petshopId = '';
  var service = '';
  var userName = '';

  Future<DocumentSnapshot<Object?>> getOrder(String orderId) async {
    DocumentReference doc = firestore.collection("order").doc(orderId);
    return doc.get();
  }

  Future<DocumentSnapshot<Object?>> getUser(String userId) async {
    DocumentReference doc = firestore.collection("users").doc(userId);
    return doc.get();
  }

  void createReview(String message) {
    CollectionReference review = firestore.collection("review");
    var userId = GetStorage().read('currentUserId');

    try {
      review.add({
        "userId": userId,
        "petshopId": petshopId,
        'rating': rating,
        'message': message,
        'service': service,
        'userName': userName,
        'reviewCreated': DateTime.now()
      });
      Get.back();
    } catch (e) {
      print(e);
    }
  }

  void done(String orderId) {
    DocumentReference docRef = firestore.collection('order').doc(orderId);

    docRef.update({'status': 'Completed'});
    Get.back();
  }
}
