import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';

class WithdrawController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var paymentType = ''.obs;

  Future<DocumentSnapshot<Object?>> getUserById(String userId) async {
    DocumentReference doc = firestore.collection("users").doc(userId);
    return doc.get();
  }

  void topUp(String userId, int balance) {
    var currentBalance = localStorage.read('balance');
    firestore
        .collection("users")
        .doc(userId)
        .update({'balance': balance + currentBalance});
  }

  void withdrawn(String userId, int balance) {
    var currentBalance = localStorage.read('balance');
    firestore
        .collection("users")
        .doc(userId)
        .update({'balance': currentBalance - balance});
  }
}
