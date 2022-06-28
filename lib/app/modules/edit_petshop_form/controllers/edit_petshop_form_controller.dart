import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

class EditPetshopFormController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  var checkValue1 = false.obs;
  var checkValue2 = false.obs;
  var checkValue3 = false.obs;

  void editPetshop(Map<String, dynamic> formData, String petshopId) {
    CollectionReference petshop = firestore.collection("petshop");

    petshop.doc(petshopId).update({
      "petshopName": formData['name'],
      "petshopAddress": formData['address'],
      "groomingService": localStorage.read('grooming'),
      "petHotelService": localStorage.read('hotel'),
      "vetServices": localStorage.read('vet'),
      "district": formData['district'],
      "city": formData['city'],
    });
    Get.toNamed(Routes.HOMEPAGE);
  }
}
