import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomepageController extends GetxController {
  var index = 0.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final localStorage = GetStorage();

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference petshop = firestore.collection("petshop");
    return petshop.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getFavByUserId() {
    var userId = localStorage.read('currentUserId');
    CollectionReference favorite = firestore.collection("favorite");
    return favorite.where('userId', isEqualTo: userId).snapshots();
  }

  Future<DocumentSnapshot<Object?>> getUserById(String userId) async {
    DocumentReference doc = firestore.collection("users").doc(userId);
    return doc.get();
  }
}
