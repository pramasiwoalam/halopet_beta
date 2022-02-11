import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final authController = Get.find<AuthController>();
  final profileController = Get.put(ProfileController());
  var userId = GetStorage().read('currentUserId');
  var userRole = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: StreamBuilder<User?>(
          stream: authController.streamUser,
          builder: (context, userSnapshot) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<DocumentSnapshot<Object?>>(
                      future: profileController.getUser(userId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          var data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          var petshopId = data['petshopId'];
                          print('petshopId: $petshopId');
                          if (data['role'] == 'Seller') {
                            return FutureBuilder<DocumentSnapshot<Object?>>(
                                future: profileController
                                    .getPetshopDetail(petshopId),
                                builder: (context, petshopSnapshot) {
                                  if (petshopSnapshot.connectionState ==
                                      ConnectionState.done) {
                                    var petshopData = petshopSnapshot.data!
                                        .data() as Map<String, dynamic>;
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            "Hello ${data['name']}",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            "Your Petshop: ${petshopData['petshopName']}",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                });
                          } else {
                            return Center(
                                child: Text('Welcome ${data['name']}'));
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                  FutureBuilder<DocumentSnapshot<Object?>>(
                      future: profileController.getUser(userId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          var data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          if (data['role'] == 'Member' &&
                              data['petshopOwner'] == false) {
                            return Column(
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.brown),
                                    onPressed: () =>
                                        Get.toNamed(Routes.ADD_PETSHOP),
                                    child: Text("Create your own petshop")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.brown),
                                    onPressed: () =>
                                        Get.toNamed(Routes.FAVORITE),
                                    child: Text("Favorite")),
                              ],
                            );
                          } else if (data['role'] == 'Member' &&
                              data['petshopOwner'] == true) {
                            return Column(
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.brown),
                                    onPressed: () => profileController
                                        .changeRoleToSeller(userId),
                                    child: Text("Edit your petshop")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.brown),
                                    onPressed: () => profileController
                                        .changeRoleToSeller(userId),
                                    child: Text("Go to seller page")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.brown),
                                    onPressed: () =>
                                        Get.toNamed(Routes.FAVORITE),
                                    child: Text("Favorite")),
                              ],
                            );
                          } else if (data['role'] == 'Seller') {
                            return Column(
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.brown),
                                    onPressed: () =>
                                        Get.toNamed(Routes.ADD_PETSHOP),
                                    child: Text("Edit your petshop")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.brown),
                                    onPressed: () => profileController
                                        .changeRoleToMember(userId),
                                    child: Text("Go Back As User"))
                              ],
                            );
                          } else {
                            return SizedBox();
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.brown),
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.INFO,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'Alert',
                          desc: 'Are you sure want to logout?',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            authController.logout();
                          },
                        ).show();
                      },
                      child: const Text("Log Out")),
                ],
              ),
            );
          }),
    );
  }
}
