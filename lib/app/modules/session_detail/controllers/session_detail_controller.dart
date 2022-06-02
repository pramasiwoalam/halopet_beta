import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';

class SessionDetailController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var paymentType = ''.obs;

  Future<DocumentSnapshot<Object?>> getSessionDetail(String sessionId) async {
    DocumentReference doc = firestore.collection("session").doc(sessionId);
    return doc.get();
  }
}
