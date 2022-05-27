import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';

class ServiceListController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void createPetshop() {
    CollectionReference petshop = firestore.collection("petshop");
    CollectionReference users = firestore.collection("users");
    var userId = GetStorage().read('currentUserId');

    print(localStorage.read('generalData'));
    var data = localStorage.read('generalData');
    try {
      var res = petshop.doc(localStorage.read('tempPetshopId')).update({
        "petshopName": data['name'],
        "petshopAddress": data['address'],
        "groomingService": localStorage.read('grooming'),
        "petHotelService": localStorage.read('hotel'),
        "vetServices": localStorage.read('vet'),
        "district": data['district'],
        "city": data['city'],
        'petshopOwner': userId,
      }).then((value) => users.doc(userId).update({
            'petshopId': localStorage.read('tempPetshopId'),
            'petshopOwner': true
          }));
      Get.back();
    } catch (e) {
      print(e);
    }
  }

  void setService(Map<String, dynamic> data) {
    CollectionReference petshop = firestore.collection("petshop");
    CollectionReference service = firestore.collection("service");
    CollectionReference users = firestore.collection("users");
    var userId = GetStorage().read('currentUserId');
    var petshopId = '';
    service.doc(localStorage.read('tempServiceId')).update({
      'petshopId': localStorage.read('tempPetshopId'),
      'serviceName': data['name']
    }).then((value) => {
          petshop.doc(localStorage.read('tempPetshopId')).set(
            {
              'serviceId': FieldValue.arrayUnion([
                {'id': localStorage.read('tempServiceId')}
              ])
            },
            SetOptions(merge: true),
          )
        });
  }

  void cancellation(String petshopId, String serviceId) {
    CollectionReference petshop = firestore.collection("petshop");
    CollectionReference service = firestore.collection("service");

    petshop
        .doc(petshopId)
        .delete()
        .then((value) => service.doc(serviceId).delete());
  }

  void registerCancellation(String petshopId) {
    CollectionReference petshop = firestore.collection("petshop");

    petshop.doc(petshopId).delete();
  }
}
