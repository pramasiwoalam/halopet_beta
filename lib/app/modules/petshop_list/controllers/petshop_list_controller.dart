import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PetshopListController extends GetxController {
  //TODO: Implement FavoriteController
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var userId = GetStorage().read('currentUserId');
  var petshopId = GetStorage().read('petshopId');

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference petshop = firestore.collection('petshop');
    return petshop.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getByMostFavorited() {
    CollectionReference petshop = firestore.collection('petshop');
    return petshop.where('favoriteId', isNotEqualTo: []).snapshots();
  }
}
