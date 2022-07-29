import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final localStorage = GetStorage();

class ServiceFormController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var packageGroomingList = [];
  var packageHotelList = [];
  var sessionList = [];

  Future<DocumentSnapshot<Object?>> getUser(String userId) async {
    DocumentReference doc = firestore.collection("users").doc(userId);
    return doc.get();
  }

  Future<DocumentSnapshot<Object?>> getPetshopDetail(String petshopId) async {
    DocumentReference doc = firestore.collection('petshop').doc(petshopId);
    return doc.get();
  }

  void createGroomingServiceDetail(Map<String, dynamic> formData) {
    CollectionReference petshop = firestore.collection("petshop");
    CollectionReference service = firestore.collection("service");
    CollectionReference package = firestore.collection("package");
    CollectionReference users = firestore.collection("users");
    var tempServiceId = localStorage.read('tempServiceId');

    package.add({
      'name': formData['name'],
      'desc': formData['desc'],
      'price': formData['price'],
      'time': formData['time'],
      'serviceId': tempServiceId
    }).then((value) => {
          service.doc(tempServiceId).set(
            {
              'packageId': FieldValue.arrayUnion([
                {'id': value.id}
              ])
            },
            SetOptions(merge: true),
          ),
        });
  }

  void createVetServiceDetail(Map<String, dynamic> formData) {
    CollectionReference service = firestore.collection("service");
    CollectionReference session = firestore.collection("session");

    var tempServiceId = localStorage.read('tempServiceId');

    session.add({
      'number': formData['number'],
      'dayOpen': formData['dayOpen'],
      'name': formData['name'],
      'time': formData['time'],
      'degree': formData['degree'],
      'specialist': formData['specialist'],
      'yearsActive': formData['yearsActive'],
      'serviceId': tempServiceId
    }).then((value) => {
          localStorage.write('tempSessionId', value.id),
          service.doc(tempServiceId).set(
            {
              'sessionId': FieldValue.arrayUnion([
                {'id': value.id}
              ])
            },
            SetOptions(merge: true),
          ),
        });
  }

  void createHotelServiceDetail(Map<String, dynamic> formData) {
    CollectionReference petshop = firestore.collection("petshop");
    CollectionReference service = firestore.collection("service");
    CollectionReference room = firestore.collection("room");
    CollectionReference users = firestore.collection("users");
    var tempServiceId = localStorage.read('tempServiceId');

    room.add({
      'name': formData['name'],
      'desc': formData['desc'],
      'price': formData['price'],
      'compatibleFor': formData['compatibleFor'],
      'serviceId': tempServiceId
    }).then((value) => {
          service.doc(tempServiceId).set(
            {
              'roomId': FieldValue.arrayUnion([
                {'id': value.id}
              ])
            },
            SetOptions(merge: true),
          ),
        });
  }

  void createSession(Map<String, dynamic> formData) {
    CollectionReference session = firestore.collection("session");
    var tempServiceId = localStorage.read('tempServiceId');
    session.add({
      'number': formData['number'],
      'dayOpen': formData['dayOpen'],
      'name': formData['name'],
      'time': formData['time'],
      'degree': formData['degree'],
      'specialist': formData['specialist'],
      'yearsActive': formData['yearsActive'],
      'serviceId': tempServiceId
    }).then((value) => localStorage.write('tempSessionId', value.id));
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
