import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

class SignupController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //TODO: Implement SignupController

  void signupUser(Map<String, dynamic> formData) {
    CollectionReference petshop = firestore.collection("petshop");
    CollectionReference users = firestore.collection("users");
    var userId = GetStorage().read('currentUserId');
    var petshopId = '';
    print('data: $formData');
    Get.toNamed(Routes.HOMEPAGE);
    final count = 0.obs;
    @override
    void onInit() {
      super.onInit();
    }

    @override
    void onReady() {
      super.onReady();
    }

    @override
    void onClose() {}
    void increment() => count.value++;
  }
}
