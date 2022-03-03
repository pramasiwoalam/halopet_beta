import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrderController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final userId = GetStorage().read('currentUserId');

  Stream<QuerySnapshot<Object?>> streamOrderByUserId() {
    CollectionReference order = firestore.collection("order");
    return order.where('userId', isEqualTo: userId).snapshots();
  }

  Stream<QuerySnapshot<Object?>> getByApprovalStatus() {
    CollectionReference order = firestore.collection("order");
    return order
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'Waiting for approval')
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>> getByPaymentStatus(String userId) {
    CollectionReference order = firestore.collection("order");
    return order
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'Waiting for payment')
        .snapshots();
  }
}
