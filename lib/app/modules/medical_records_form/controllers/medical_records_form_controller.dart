import 'dart:async';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

class MedicalRecordsFormController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  double rating = 0;
  var petshopId = '';
  var service = '';
  var userName = '';
  var date = 'null'.obs;

  Future<DocumentSnapshot<Object?>> getOrder(String orderId) async {
    DocumentReference doc = firestore.collection("order").doc(orderId);
    return doc.get();
  }

  Future<DocumentSnapshot<Object?>> getUser(String userId) async {
    DocumentReference doc = firestore.collection("users").doc(userId);
    return doc.get();
  }

  void createMedicalRecords(Map<String, dynamic> formData) {
    CollectionReference medicalRecords =
        firestore.collection("medical_records");
    CollectionReference pets = firestore.collection("pets");

    var petId = GetStorage().read('temporaryPetId');
    print('PETID$petId');

    medicalRecords.add({
      'petId': petId,
      'info': formData['info'],
      'date': date.toString(),
      'author': formData['author']
    }).then(
      (value) => pets.doc(petId).update({'isMedical': true}),
    );
    Timer(Duration(milliseconds: 500), () {
      Get.toNamed(Routes.MEDICAL_RECORDS_LIST, arguments: petId);
    });
  }
}
