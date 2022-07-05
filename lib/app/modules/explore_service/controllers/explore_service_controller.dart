import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ExploreServiceController extends GetxController {
  //TODO: Implement FavoriteController
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var userId = GetStorage().read('currentUserId');
  var petshopId = GetStorage().read('petshopId');

  Stream<QuerySnapshot<Object?>> getByGrooming() {
    CollectionReference petshop = firestore.collection('petshop');
    return petshop.where('groomingService', isEqualTo: true).snapshots();
  }

  Stream<QuerySnapshot<Object?>> getByVet() {
    CollectionReference petshop = firestore.collection('petshop');
    return petshop.where('vetServices', isEqualTo: true).snapshots();
  }

  Stream<QuerySnapshot<Object?>> getByHotel() {
    CollectionReference petshop = firestore.collection('petshop');
    return petshop.where('petHotelService', isNotEqualTo: true).snapshots();
  }
}
