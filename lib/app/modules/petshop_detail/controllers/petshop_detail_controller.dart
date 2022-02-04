import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PetshopDetailController extends GetxController {
  var isFav = false.obs;

  var orderList = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getPetshopDetail(String petshopId) async {
    DocumentReference doc = firestore.collection("petshop").doc(petshopId);
    return doc.get();
  }

  void createFavorite(bool isFav) {
    CollectionReference favorite = firestore.collection("favorite");

    var userId = GetStorage().read('currentUserId');
    var petshopId = GetStorage().read('petshopId');
    var batch = firestore.batch();

    try {
      if (isFav == true) {
        favorite
            .add({'userId': userId, 'petshopId': petshopId, 'isFav': isFav});
      } else {}
    } catch (e) {
      print(e);
    }
  }
}
