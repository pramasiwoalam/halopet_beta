import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PackageListController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final localStorage = GetStorage();

  Stream<QuerySnapshot<Object?>> getPackageByServiceId(String serviceId) {
    CollectionReference package = firestore.collection("package");
    return package.where('serviceId', isEqualTo: serviceId).snapshots();
  }
}
