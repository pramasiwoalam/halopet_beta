import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  var index = 0.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference petshop = firestore.collection("petshop");
    return petshop.snapshots();
  }

  @override
  void onInit() {
    index = 0.obs;
  }
}
