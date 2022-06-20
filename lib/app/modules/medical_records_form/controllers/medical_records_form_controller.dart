import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';

class MedicalRecordsFormController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  double rating = 0;
  var petshopId = '';
  var service = '';
  var userName = '';
  var date = 'null'.obs;

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
    CollectionReference medical_records =
        firestore.collection("medical_records");

    var petId = GetStorage().read('temporaryPetId');

    try {
      medical_records.add({
        'petId': petId,
        'info': formData['info'],
        'date': date,
        'author': formData['author']
      }).then(
        (value) => {
          pets.doc(petId).set(
            {
              'medicalRecordsId': FieldValue.arrayUnion([
                {'medicalRecordsId': value.id}
              ])
            },
            SetOptions(merge: true),
          ),
        },
      );
    } catch (e) {
      print('ERROR : $e');
    }
  }
}
