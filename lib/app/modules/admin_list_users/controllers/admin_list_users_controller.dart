import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminListUsersController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamOrder() {
    CollectionReference users = firestore.collection("users");
    return users.snapshots();
  }
}
