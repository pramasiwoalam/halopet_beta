import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminListUsersController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamUser() {
    CollectionReference users = firestore.collection("users");
    return users.snapshots();
  }

  void deleteUser(String userId) {
    CollectionReference users = firestore.collection("users");
    users.doc(userId).delete();
  }

  Future<DocumentSnapshot<Object?>> getUser(String userId) async {
    DocumentReference doc = firestore.collection("users").doc(userId);
    return doc.get();
  }
}
