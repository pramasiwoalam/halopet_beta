import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';

class ChoosePetController extends GetxController {
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
    try {
      return doc.get();
    } catch (e) {
      print(e);
      return doc.get();
    }
  }

  Stream<QuerySnapshot<Object?>> getPets() {
    CollectionReference pets = firestore.collection("pets");
    CollectionReference users = firestore.collection("users");
    var userId = localStorage.read('currentUserId');

    return pets.where('userId', isEqualTo: userId).snapshots();
  }
}
