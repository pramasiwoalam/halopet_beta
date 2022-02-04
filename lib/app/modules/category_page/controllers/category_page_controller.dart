import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryPageController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamData(int value) {
    CollectionReference petshop = firestore.collection("petshop");

    if (value == 1) {
      // return petshop.snapshots();
      // print(petshop as Map<String, dynamic>);
      return petshop.where('groomingService', isEqualTo: true).snapshots();
    } else if (value == 2) {
      return petshop.where('vetServices', isEqualTo: true).snapshots();
    } else {
      return petshop.where('petHotelService', isEqualTo: true).snapshots();
    }
  }
}
