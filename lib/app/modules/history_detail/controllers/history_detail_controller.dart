import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HistoryDetailController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getOrder(String orderId) async {
    DocumentReference doc = firestore.collection("order").doc(orderId);
    return doc.get();
  }
}
