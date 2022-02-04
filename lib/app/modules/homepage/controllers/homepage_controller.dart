import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/order/views/order_view.dart';
import 'package:halopet_beta/app/modules/profile/views/profile_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

class HomepageController extends GetxController {
  var index = 0.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final localStorage = GetStorage();

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference petshop = firestore.collection("petshop");
    return petshop.snapshots();
  }

  Future<DocumentSnapshot<Object?>> getUserById(String userId) async {
    DocumentReference doc = firestore.collection("users").doc(userId);
    return doc.get();
  }
}
