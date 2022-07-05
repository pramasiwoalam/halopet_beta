import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

class MedicalListFormController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  var checkValue1 = false.obs;
  var checkValue2 = false.obs;
  var checkValue3 = false.obs;

  void registerMedicalService(Map<String, dynamic> formData) {
    CollectionReference service = firestore.collection("medical_service");

    var sessionId = localStorage.read('tempSessionId');

    service.add({
      'name': formData['name'],
      'desc': formData['desc'],
      'sessionId': sessionId
    }).then((value) => {
          service.doc(sessionId).set(
            {
              'medListId': FieldValue.arrayUnion([
                {'id': value.id}
              ])
            },
            SetOptions(merge: true),
          ),
        });
  }
}
