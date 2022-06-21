import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

class PetFormController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  double rating = 0;
  var petshopId = '';
  var service = '';
  var userName = '';

  Future<DocumentSnapshot<Object?>> getOrder(String orderId) async {
    DocumentReference doc = firestore.collection("order").doc(orderId);
    return doc.get();
  }

  Future<DocumentSnapshot<Object?>> getUser(String userId) async {
    DocumentReference doc = firestore.collection("users").doc(userId);
    return doc.get();
  }

  void createPets(Map<String, dynamic> formData) {
    CollectionReference pets = firestore.collection("pets");
    CollectionReference users = firestore.collection("users");
    var userId = GetStorage().read('currentUserId');

    pets.add({
      'userId': userId,
      'name': formData['name'],
      'desc': formData['desc'],
      'birth': formData['birth'],
      'gender': formData['gender'],
      'species': formData['species'],
      'age': formData['age'],
      'weight': formData['weight'],
      'color': formData['color'],
      'isMedical': false,
      'img': 'assets/images/freddy.jpg'
    }).then(
      (value) => {
        print(value.id),
        users.doc(userId).set(
          {
            'pets': FieldValue.arrayUnion([
              {'petId': value.id}
            ])
          },
          SetOptions(merge: true),
        ),
        localStorage.write('temporaryPetId', value.id),
        Get.toNamed(Routes.MEDICAL_RECORDS_LIST, arguments: value.id),
      },
    );
  }
}
