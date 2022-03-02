import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
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
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Profile',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
        )),
        centerTitle: true,
        backgroundColor: Color(0xffF9813A),
        elevation: 0,
      ),
      body: StreamBuilder<User?>(
          stream: authController.streamUser,
          builder: (context, userSnapshot) {
            return Column(
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      height: height * 0.25,
                      width: width,
                      // color: Colors.blue,
                      child: SizedBox(
                        height: height * 0.2,
                        width: width,
                        child: Stack(
                          children: [
                            ClipPath(
                              clipper: CustomShape(),
                              child: Container(
                                height: height * 0.15,
                                color: Color(0xffF9813A),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  height: height / 5.5,
                                  width: width * 0.35,
                                  // color: Colors.pink,
                                  margin: EdgeInsets.only(
                                      left: width * 0.33, top: height * 0.06),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: width * 0.01,
                                            top: height * 0.01,
                                            bottom: height * 0.005),
                                        height: height / 4,
                                        width: width / 3.5,
                                        // color: Colors.blue,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.black,
                                              width: width * 0.4),
                                          image: const DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/user.png')),
                                        ),
                                      ),
                                      // Text("Hallo ${data['name']}",
                                      //             style: TextStyle(fontSize: 20),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(0.5),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder<DocumentSnapshot<Object?>>(
                          future: profileController.getUser(userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
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
                                                style: GoogleFonts.inter(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                "Your Petshop: ${petshopData['petshopName']}",
                                                style: GoogleFonts.inter(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    });
                              } else {
                                return Center(
                                    child: Text(
                                  'Hallo ${data['name']}',
                                  style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ));
                              }
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                      FutureBuilder<DocumentSnapshot<Object?>>(
                          future: profileController.getUser(userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              var data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              if (data['role'] == 'Member' &&
                                  data['petshopOwner'] == false) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        color: Colors.grey.shade200,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.person,
                                              color: Color(0xffF9813A),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Create your own petshop",
                                                style: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios),
                                          ],
                                        ),
                                        onPressed: () =>
                                            Get.toNamed(Routes.ADD_PETSHOP),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        color: Colors.grey.shade200,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              color: Color(0xffF9813A),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Favorite Petshop",
                                                style: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios),
                                          ],
                                        ),
                                        onPressed: () =>
                                            Get.toNamed(Routes.FAVORITE),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (data['role'] == 'Member' &&
                                  data['petshopOwner'] == true) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        color: Colors.grey.shade200,
                                        child: Row(
                                          children: [
                                            const Icon(Icons.edit_attributes,
                                                color: Color(0xffF9813A)),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Edit your petshop",
                                                style: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios),
                                          ],
                                        ),
                                        onPressed: () => profileController
                                            .changeRoleToSeller(userId),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        color: Colors.grey.shade200,
                                        child: Row(
                                          children: [
                                            Icon(Icons.sell_sharp),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Go to seller page",
                                                style: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios),
                                          ],
                                        ),
                                        onPressed: () => profileController
                                            .changeRoleToSeller(userId),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        color: Colors.grey.shade200,
                                        child: Row(
                                          children: [
                                            Icon(Icons.favorite),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Favorite",
                                                style: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios),
                                          ],
                                        ),
                                        onPressed: () =>
                                            Get.toNamed(Routes.FAVORITE),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (data['role'] == 'Seller') {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        color: Colors.grey.shade200,
                                        child: Row(
                                          children: [
                                            Icon(Icons.edit_attributes),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Edit your petshop",
                                                style: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios),
                                          ],
                                        ),
                                        onPressed: () =>
                                            Get.toNamed(Routes.ADD_PETSHOP),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        color: Colors.grey.shade200,
                                        child: Row(
                                          children: [
                                            Icon(Icons.emoji_people),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Go Back As User",
                                                style: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios),
                                          ],
                                        ),
                                        onPressed: () => profileController
                                            .changeRoleToMember(userId),
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return SizedBox();
                              }
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: FlatButton(
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.grey.shade200,
                          child: Row(
                            children: [
                              Icon(Icons.logout, color: Color(0xffF9813A)),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  "Log Out",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      leading: SizedBox(),
      title: Text('Profile'),
      centerTitle: true,
      backgroundColor: Colors.orange.shade500,
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
