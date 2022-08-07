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

    var data = localStorage.read('generalData');
    try {
      var res = petshop.doc(localStorage.read('tempPetshopId')).update({
        "petshopName": data['name'],
        "petshopAddress": data['address'],
        "district": data['district'],
        "address": data['address'],
        "city": data['city'],
        "desc": data['desc'],
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

  void createGroomingService() {
    CollectionReference petshop = firestore.collection("petshop");
    CollectionReference service = firestore.collection("service");
    var tempPetshopId = localStorage.read('tempPetshopId');
    print(tempPetshopId);

    service.add({'name': 'Grooming Service', 'petshopId': tempPetshopId}).then(
        (value) => {
              localStorage.write('tempServiceId', value.id),
              petshop.doc(tempPetshopId).update({'groomingService': true})
            });
  }

  void createVetService() {
    CollectionReference petshop = firestore.collection("petshop");
    CollectionReference service = firestore.collection("service");
    var tempPetshopId = localStorage.read('tempPetshopId');
    print(tempPetshopId);

    service.add({'name': 'Vet Service', 'petshopId': tempPetshopId}).then(
        (value) => {
              localStorage.write('tempServiceId', value.id),
              petshop.doc(tempPetshopId).update({'vetService': true})
            });
  }

  void createHotelService() {
    CollectionReference petshop = firestore.collection("petshop");
    CollectionReference service = firestore.collection("service");
    var tempPetshopId = localStorage.read('tempPetshopId');
    print(tempPetshopId);

    service.add({'name': 'Pet Hotel Service', 'petshopId': tempPetshopId}).then(
        (value) => {
              localStorage.write('tempServiceId', value.id),
              petshop.doc(tempPetshopId).update({'petHotelService': true})
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
