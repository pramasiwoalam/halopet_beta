import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final localStorage = GetStorage();

class ServiceFormController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var packageGroomingList = [];
  var packageHotelList = [];

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
      'serviceId': localStorage.read('tempServiceId')
    }).then((value) => {
          service.doc(localStorage.read('tempServiceId')).set(
            {
              'packageId': FieldValue.arrayUnion([
                {'id': value.id}
              ])
            },
            SetOptions(merge: true),
          ),
        });
  }

  void createDefaultService() {
    CollectionReference service = firestore.collection("service");
    service.add({'packageId': null}).then((value) => {
          localStorage.write('tempServiceId', value.id),
          localStorage.write('serviceFlag', 1)
        });
  }

  void createService() {
    CollectionReference petshop = firestore.collection("petshop");

    petshop.doc(localStorage.read('tempPetshopId')).set(
      {
        'serviceId': FieldValue.arrayUnion([
          {'id': localStorage.read('tempPetshopId')}
        ])
      },
      SetOptions(merge: true),
    );
  }
}
