import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final localStorage = GetStorage();

class ServiceFormController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var packageList = [];

  Future<DocumentSnapshot<Object?>> getUser(String userId) async {
    DocumentReference doc = firestore.collection("users").doc(userId);
    return doc.get();
  }

  Future<DocumentSnapshot<Object?>> getPetshopDetail(String petshopId) async {
    DocumentReference doc = firestore.collection('petshop').doc(petshopId);
    return doc.get();
  }

  void createServiceDetail(Map<String, dynamic> formData) {
    CollectionReference petshop = firestore.collection("petshop");
    CollectionReference service = firestore.collection("service");
    CollectionReference package = firestore.collection("package");
    CollectionReference users = firestore.collection("users");
    var userId = GetStorage().read('currentUserId');
    var petshopId = '';
    package.add({
      'name': formData['name'],
      'desc': formData['desc'],
      'price': formData['price'],
      'time': formData['time'],
      'serviceId': localStorage.read('savedServiceId')
    }).then((value) => {
          localStorage.write('savedPackageId', value.id),
          service
              .doc(localStorage.read('savedServiceId'))
              .update({'packageId': value.id})
        });
  }
}
