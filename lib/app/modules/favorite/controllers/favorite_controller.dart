import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavoriteController extends GetxController {
  //TODO: Implement FavoriteController
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var userId = GetStorage().read('currentUserId');
  var petshopId = GetStorage().read('petshopId');

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference favorite = firestore.collection("favorite");
    return favorite.snapshots();
  }

  // Stream<QuerySnapshot<Object?>> getFavByUserId() {
  //   CollectionReference favorite = firestore.collection("favorite");
  //   return favorite
  //       .where(FieldPath.documentId, whereIn: favoriteArr)
  //       .snapshots();
  // }

  Stream<QuerySnapshot<Object?>> getPetshopByFavId() {
    List favoriteArr = GetStorage().read('favArr');
    print(favoriteArr);
    CollectionReference petshop = firestore.collection("petshop");
    CollectionReference users = firestore.collection("users");
    if (favoriteArr.isNotEmpty) {
      return petshop
          .where('favoriteId', arrayContainsAny: favoriteArr)
          .snapshots();
    } else {
      return petshop.where('favoriteId', isEqualTo: 0).snapshots();
    }
  }
}
