import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SellerHistoryController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference order = firestore.collection("order");
    return order.snapshots();
  }
}
