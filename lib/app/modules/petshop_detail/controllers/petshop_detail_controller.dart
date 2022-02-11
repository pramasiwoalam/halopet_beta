import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PetshopDetailController extends GetxController {
  var isFav = false.obs;

  var orderList = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var localStorage = GetStorage();

  Future<DocumentSnapshot<Object?>> getPetshopDetail(String petshopId) async {
    DocumentReference doc = firestore.collection("petshop").doc(petshopId);
    return doc.get();
  }

  Stream<QuerySnapshot<Object?>> getFavByPetshopId(
      String petshopId, String userId) {
    CollectionReference favorite = firestore.collection("favorite");

    return favorite
        .where('petshopId', isEqualTo: petshopId)
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  void createFavorite(bool isFav) {
    var userId = GetStorage().read('currentUserId');
    var petshopId = GetStorage().read('petshopId');
    CollectionReference favorite = firestore.collection("favorite");
    CollectionReference users = firestore.collection("users");
    CollectionReference petshop = firestore.collection("petshop");
    print('isfav: $isFav');
    try {
      if (isFav == true) {
        favorite.add(
            {'userId': userId, 'petshopId': petshopId, 'isFav': isFav}).then(
          (value) => {
            users.doc(userId).set(
              {
                'favoriteId': FieldValue.arrayUnion([
                  {'favId': value.id}
                ])
              },
              SetOptions(merge: true),
            ),
            petshop.doc(petshopId).set(
              {
                'favoriteId': FieldValue.arrayUnion([
                  {'favId': value.id}
                ])
              },
              SetOptions(merge: true),
            )
          },
        );
      } else if (isFav == false) {
        print('asd');
        firestore
            .collection('favorite')
            .where('petshopId', isEqualTo: petshopId)
            .get()
            .then((value) => value.docs.forEach((element) {
                  favorite.doc(element.id).delete();
                  users.doc(userId).update({
                    'favoriteId': FieldValue.arrayRemove([
                      {'favId': element.id}
                    ])
                  });
                  localStorage.remove('favArr');
                  petshop.doc(petshopId).update({
                    'favoriteId': FieldValue.arrayRemove([
                      {'favId': element.id}
                    ])
                  });
                }));
      }

      // users.where('favId', isEqualTo: localStorage.read('favoriteId')).get().then((value) => null)
    } catch (e) {
      print(e);
    }
  }
}
