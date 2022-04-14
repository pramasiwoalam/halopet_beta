import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

class AddPetshopController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  var checkValue1 = false.obs;
  var checkValue2 = false.obs;
  var checkValue3 = false.obs;

  void createPetshop(Map<String, dynamic> formData) {
    CollectionReference petshop = firestore.collection("petshop");
    CollectionReference users = firestore.collection("users");
    var userId = GetStorage().read('currentUserId');
    var petshopId = '';

    try {
      var res =
          petshop.add({'status': 'Waiting for Approval'}).then((value) => {
                localStorage.write('tempPetshopId', value.id),
                users.doc(userId).update({'petshopId': value.id})
              });
      Get.back();
    } catch (e) {
      print(e);
    }
  }
}
