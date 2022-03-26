import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';

class ServiceListController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void createPetshop(Map<String, dynamic> formData) {
    CollectionReference petshop = firestore.collection("petshop");
    CollectionReference users = firestore.collection("users");
    var userId = GetStorage().read('currentUserId');
    var petshopId = '';

    localStorage.write('groomingForm', formData);
    Map<String, dynamic> form = GetStorage().read('groomingForm');
    print(formData);
    print('desc adalah ${form['desc']}');

    // try {
    //   var res = petshop.add({
    //     "petshopName": formData['name'],
    //     "petshopAddress": formData['address'],
    //     // "groomingService": value1,
    //     // "groomingPriceRange": grPrice,
    //     // "groomingTypeList": grType,
    //     // "petHotelService": value2,
    //     // "petHotelPrice": htPrice,
    //     // "petHotelType": htType,
    //     // "vetServices": value3,
    //     'petshopOwner': userId,
    //     'status': 'Waiting for Approval'
    //   }).then((value) => {
    //         users.doc(userId).update({'petshopId': value.id})
    //       });
    //   Get.back();
    // } catch (e) {
    //   print(e);
    // }
  }
}
