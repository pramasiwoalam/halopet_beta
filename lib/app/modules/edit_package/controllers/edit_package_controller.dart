import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EditPackageController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference order = firestore.collection("order");
    return order.snapshots();
  }

  void updateGrooming(Map<String, dynamic> formData, String packageId) {
    CollectionReference petshop = firestore.collection("petshop");

    CollectionReference package = firestore.collection("package");

    package.doc(packageId).update({
      'name': formData['name'],
      'desc': formData['desc'],
      'price': formData['price'],
      'time': formData['time'],
    });
  }
}
