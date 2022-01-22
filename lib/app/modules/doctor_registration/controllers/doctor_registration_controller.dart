import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DoctorRegistrationController extends GetxController {
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void registerDoctor(String name, String description, String currentUserId) {
    CollectionReference doctor = firestore.collection("doctor");

    try {
      doctor.add({
        "name": name,
        "description": description,
        "addedBy": currentUserId
      });

      Get.back();
    }
    catch (e) {
      print(e);
    }
  }

}
