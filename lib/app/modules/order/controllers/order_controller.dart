import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrderController extends GetxController {
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final localStorage = GetStorage();

  Stream<QuerySnapshot<Object?>> streamOrder() {
    var userId = localStorage.read('currentUserId');
    CollectionReference order = firestore.collection("order");
    return order.snapshots();
  }

}
