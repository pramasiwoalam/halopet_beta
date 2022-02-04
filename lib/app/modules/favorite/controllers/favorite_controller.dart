import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  //TODO: Implement FavoriteController
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference petshop = firestore.collection("petshop");
    return petshop.snapshots();
  }
}
