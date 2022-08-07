import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final localStorage = GetStorage();
  final homeController = Get.put(HomepageController());

  Stream<User?> get streamUser => auth.authStateChanges();

  void resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Stream<DocumentSnapshot<Object?>> streamRole() {
    var userId = localStorage.read('currentUserId');
    DocumentReference doc = firestore.collection('users').doc(userId);
    return doc.snapshots();
  }

  Future<Object?> login(String email, String password) async {
    try {
      var res = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      localStorage.write('currentUserId', res.user!.uid);

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return e.code;
    }
  }

  void autoLogin(String email, String password) async {
    auth.signInWithEmailAndPassword(email: "asd", password: "asd");
  }

  void signUp(Map<String, dynamic> formData) async {
    try {
      var res = await auth.createUserWithEmailAndPassword(
          email: formData['email'], password: formData['password']);
      addUserCollection(formData, res.user!.uid);
      Get.back();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void logout() async {
    await auth.currentUser!.reload();
    await FirebaseAuth.instance.signOut();

    homeController.index = 0.obs;
  }

  void addUserCollection(Map<String, dynamic> formData, String uid) async {
    CollectionReference user = firestore.collection("users");

    try {
      // await user.add({
      //   "email" : email,
      //   "uid" : uid,
      //   "role" : "member"
      // });

      await user.doc(uid).set({
        "name": formData['name'],
        "email": formData['email'],
        "userId": uid,
        "role": "Member",
        "petshopOwner": false,
        "balance": 0,
        "address": formData['address'],
        "district": formData['district'],
        "city": formData['city'],
        "postalCode": formData['postalCode'],
        "phone": formData['phone'],
        'img': 'assets/images/user.png'
      });

      Get.dialog(AlertDialog(
        title: Text(
          'Welcome',
          style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 14),
        ),
        titlePadding: EdgeInsets.only(left: 26, right: 26, top: 30),
        contentPadding:
            EdgeInsets.only(left: 26, right: 26, top: 16, bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
            'Register success. Welcome to HaloPet. The solution for your pet needs.',
            style: TextStyle(fontFamily: 'SanFrancisco.Light', fontSize: 12)),
        actionsPadding: EdgeInsets.only(right: 12, top: 6, bottom: 2),
        actions: [
          TextButton(
              onPressed: () => {Get.back()},
              child: Text(
                'Agreed.',
                style: TextStyle(
                    fontFamily: 'SanFrancisco',
                    fontSize: 13,
                    color: Colors.orange),
              )),
        ],
      ));
    } catch (e) {
      Get.defaultDialog(
          title: "Register Failed",
          middleText: "Please try again",
          onConfirm: () => Get.back(),
          textConfirm: "Ok");
    }
  }
}
