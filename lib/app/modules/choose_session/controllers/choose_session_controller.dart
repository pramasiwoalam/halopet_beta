import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';

class ChooseSessionController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  double rating = 0;
  var petshopId = '';
  var service = '';
  var userName = '';

  var vetFlag = false;

  Future<DocumentSnapshot<Object?>> getOrder(String orderId) async {
    DocumentReference doc = firestore.collection("order").doc(orderId);
    return doc.get();
  }

  Stream<QuerySnapshot<Object?>> getSession() {
    CollectionReference session = firestore.collection("session");
    return session.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getPets() {
    CollectionReference pets = firestore.collection("pets");

    var userId = localStorage.read('currentUserId');

    return pets.where('userId', isEqualTo: userId).snapshots();
  }

  void setService() {
    CollectionReference petshop = firestore.collection("petshop");
    CollectionReference service = firestore.collection("service");
    CollectionReference users = firestore.collection("users");
    var userId = GetStorage().read('currentUserId');
    var petshopId = '';
    service.doc(localStorage.read('tempServiceId')).update({
      'petshopId': localStorage.read('tempPetshopId'),
      'serviceName': "Vet"
    }).then((value) => {
          petshop.doc(localStorage.read('tempPetshopId')).set(
            {
              'serviceId': FieldValue.arrayUnion([
                {'id': localStorage.read('tempServiceId')}
              ])
            },
            SetOptions(merge: true),
          )
        });
  }
}
