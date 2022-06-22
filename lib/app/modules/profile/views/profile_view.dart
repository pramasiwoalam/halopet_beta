import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import 'package:money_formatter/money_formatter.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final authController = Get.find<AuthController>();
  final profileController = Get.put(ProfileController());
  var userId = GetStorage().read('currentUserId');
  var userRole = ''.obs;
  var items = [
    'OPEN',
    'CLOSED',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          'Profile',
          style: TextStyle(
              fontFamily: 'SanFrancisco',
              fontSize: 17,
              color: Colors.grey.shade800),
        )),
        leading: Icon(Icons.abc),
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
        elevation: 0.1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FlatButton(
              minWidth: 5,
              onPressed: () => Get.toNamed(Routes.NOTIFICATION_LIST),
              child: Stack(
                children: [
                  Icon(
                    Icons.notifications,
                    size: 26,
                    color: Colors.grey.shade700,
                  ),
                  StreamBuilder<QuerySnapshot<Object?>>(
                      stream: profileController.getUnreadNotification(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          var data = snapshot.data!.docs;
                          var unreadNotification = '';
                          if (data.isEmpty) {
                            unreadNotification = 0.toString();
                          } else {
                            unreadNotification = data.length.toString();
                          }
                          return Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: 3, left: 12),
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Center(
                                      child: Text(
                                    '$unreadNotification',
                                    style: TextStyle(
                                        fontSize: 9, color: Colors.white),
                                  )),
                                ),
                              ));
                        } else {
                          return CircularProgressIndicator();
                        }
                      })
                ],
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<User?>(
          stream: authController.streamUser,
          builder: (context, userSnapshot) {
            return FutureBuilder<DocumentSnapshot<Object?>>(
                future: profileController.getUser(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    var data = snapshot.data!.data() as Map<String, dynamic>;
                    var petshopId = data['petshopId'];
                    print(petshopId);
                    int balance = data['balance'];
                    MoneyFormatter fmf = MoneyFormatter(
                        amount: balance.roundToDouble(),
                        settings: MoneyFormatterSettings(
                          symbol: 'Rp.',
                          thousandSeparator: '.',
                          decimalSeparator: ',',
                          symbolAndNumberSeparator: ' ',
                        ));
                    MoneyFormatterOutput fo = fmf.output;
                    return Column(
                      children: [
                        Column(
                          children: <Widget>[
                            Container(
                              height: height * 0.11,
                              width: width,
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.2, color: Colors.grey.shade400)),
                              // color: Colors.blue,
                              child: SizedBox(
                                height: height * 0.2,
                                width: width,
                                child: Stack(
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: height * 0.08,
                                          width: width,
                                          // color: Colors.pink,
                                          margin: EdgeInsets.only(
                                              left: width * 0.01, top: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  height: height / 7,
                                                  width: width / 7,
                                                  // color: Colors.blue,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: width * 0.4),
                                                      image: DecorationImage(
                                                          fit: data['role'] ==
                                                                  'Member'
                                                              ? BoxFit.fitWidth
                                                              : BoxFit.cover,
                                                          image: data['role'] ==
                                                                  'Member'
                                                              ? AssetImage(
                                                                  'assets/images/user.jpeg')
                                                              : AssetImage(
                                                                  'assets/images/petshop-1.jpg')))),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                    left: 10,
                                                  ),
                                                  height: height * 0.07,
                                                  width: width * 0.65,
                                                  child: data['role'] ==
                                                          'Member'
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Gheara Arsyandra',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'SanFrancisco',
                                                                  fontSize: 15),
                                                            ),
                                                            Spacer(),
                                                            Text(
                                                                'Jakarta, Indonesia',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'SanFrancisco.Light',
                                                                    fontSize:
                                                                        13)),
                                                            Spacer(),
                                                            Text('Member',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .orange,
                                                                    fontFamily:
                                                                        'SanFrancisco',
                                                                    fontSize:
                                                                        12))
                                                          ],
                                                        )
                                                      : FutureBuilder<
                                                              DocumentSnapshot<
                                                                  Object?>>(
                                                          future: profileController
                                                              .getPetshopDetail(
                                                                  petshopId),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .done) {
                                                              var petshop = snapshot
                                                                      .data!
                                                                      .data()
                                                                  as Map<String,
                                                                      dynamic>;
                                                              return Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        petshop[
                                                                            'petshopName'],
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'SanFrancisco',
                                                                            fontSize:
                                                                                15),
                                                                      ),
                                                                      // DropdownButtonHideUnderline(
                                                                      //   child:
                                                                      //       DropdownButton2(
                                                                      //     hint:
                                                                      //         Text(
                                                                      //       profileController.status.value.isEmpty
                                                                      //           ? 'Open'
                                                                      //           : 'Closed',
                                                                      //       style:
                                                                      //           TextStyle(
                                                                      //         fontSize: 14,
                                                                      //         color: Theme.of(context).hintColor,
                                                                      //       ),
                                                                      //     ),
                                                                      //     items: items
                                                                      //         .map((item) => DropdownMenuItem<String>(
                                                                      //               value: item,
                                                                      //               child: Text(
                                                                      //                 item,
                                                                      //                 style: const TextStyle(
                                                                      //                   fontSize: 14,
                                                                      //                 ),
                                                                      //               ),
                                                                      //             ))
                                                                      //         .toList(),
                                                                      //     value:
                                                                      //         selectedValue,
                                                                      //     onChanged:
                                                                      //         (value) {
                                                                      //       profileController.status.value =
                                                                      //           value.toString();
                                                                      //       print(profileController.status.value);
                                                                      //     },
                                                                      //     buttonHeight:
                                                                      //         40,
                                                                      //     buttonWidth:
                                                                      //         140,
                                                                      //     itemHeight:
                                                                      //         40,
                                                                      //   ),
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                      'Jakarta, Indonesia',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'SanFrancisco.Light',
                                                                          fontSize:
                                                                              13)),
                                                                  Spacer(),
                                                                  Text('Seller',
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xff2596BE),
                                                                          fontFamily:
                                                                              'SanFrancisco',
                                                                          fontSize:
                                                                              12))
                                                                ],
                                                              );
                                                            } else {
                                                              return Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            }
                                                          }))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.1,
                              width: width * 0.9,
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 0.8, color: Colors.grey.shade300),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade200,
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(1, 2))
                                  ]),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.monetization_on,
                                            color: Colors.orange,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${fo.symbolOnLeft}",
                                                style: GoogleFonts.roboto(
                                                    color: Colors.grey.shade800,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                'PawPay Coins',
                                                style: GoogleFonts.roboto(
                                                    color: Colors.grey.shade800,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 11),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      VerticalDivider(
                                        color: Colors.grey.shade300,
                                        thickness: 1,
                                      ),
                                      InkWell(
                                        onTap: () => {
                                          Get.toNamed(Routes.TOPUP),
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Colors.orange,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Top up PawPay',
                                              style: GoogleFonts.roboto(
                                                  color: Colors.grey.shade800,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.5),
                          child: Column(
                            children: [
                              data['role'] == 'Seller'
                                  ? FutureBuilder<DocumentSnapshot<Object?>>(
                                      future: profileController
                                          .getPetshopDetail(petshopId),
                                      builder: (context, petshopSnapshot) {
                                        if (petshopSnapshot.connectionState ==
                                            ConnectionState.done) {
                                          var petshopData =
                                              petshopSnapshot.data!.data()
                                                  as Map<String, dynamic>;
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30,
                                                        vertical: 10),
                                                child: FlatButton(
                                                    padding: EdgeInsets.all(20),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                    color: Colors.grey.shade100,
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                            Icons.find_replace,
                                                            color: Color(
                                                                0xff2596BE)),
                                                        const SizedBox(
                                                          width: 30,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "Go back as member",
                                                            style: GoogleFonts.inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          size: 20,
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () => {
                                                          profileController
                                                              .changeRoleToMember(
                                                                  userId)
                                                        }),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      })
                                  : data['role'] == 'Member' &&
                                          data['petshopOwner'] == false
                                      ? Column(
                                          children: [
                                            Container(
                                              height: height * 0.042,
                                              width: width * 0.8,
                                              color: Colors.transparent,
                                              child: Center(
                                                child: MaterialButton(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                          child: Text(
                                                              "Create your own petshop",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'SanFrancisco.Light',
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize:
                                                                      14)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  onPressed: () => Get.toNamed(
                                                      Routes.ADD_PETSHOP),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 5),
                                              child: FlatButton(
                                                padding: EdgeInsets.all(15),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                color: Colors.grey.shade100,
                                                height: height * 0.08,
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.pets,
                                                      color: Color(0xffF9813A),
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    Expanded(
                                                      child: Text("My Pets",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 14)),
                                                    ),
                                                    Icon(Icons
                                                        .arrow_forward_ios),
                                                  ],
                                                ),
                                                onPressed: () => Get.toNamed(
                                                    Routes.PET_LIST),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 5),
                                              child: FlatButton(
                                                padding: EdgeInsets.all(15),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                color: Colors.grey.shade100,
                                                height: height * 0.08,
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.people,
                                                      color: Color(0xffF9813A),
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                          "Personal Detail",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 14)),
                                                    ),
                                                    Icon(Icons
                                                        .arrow_forward_ios),
                                                  ],
                                                ),
                                                onPressed: () => Get.toNamed(
                                                    Routes.FAVORITE),
                                              ),
                                            ),
                                          ],
                                        )
                                      : data['role'] == 'Member' &&
                                              data['petshopOwner'] == true
                                          ? Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 30,
                                                      vertical: 10),
                                                  child: FlatButton(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      color:
                                                          Colors.grey.shade100,
                                                      child: Row(
                                                        children: [
                                                          const Icon(Icons.pets,
                                                              color: Color(
                                                                  0xffF9813A)),
                                                          const SizedBox(
                                                            width: 30,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "Pet List",
                                                              style: GoogleFonts.inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ),
                                                          Icon(Icons
                                                              .arrow_forward_ios),
                                                        ],
                                                      ),
                                                      onPressed: () => {
                                                            Get.toNamed(
                                                                Routes.PET_LIST)
                                                          }),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 30,
                                                      vertical: 10),
                                                  child: FlatButton(
                                                    padding: EdgeInsets.all(20),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                    color: Colors.grey.shade100,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.shopify,
                                                          color:
                                                              Color(0xffF9813A),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "Go to seller page",
                                                            style: GoogleFonts.inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        Icon(Icons
                                                            .arrow_forward_ios),
                                                      ],
                                                    ),
                                                    onPressed: () =>
                                                        profileController
                                                            .changeRoleToSeller(
                                                                userId),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 30,
                                                      vertical: 10),
                                                  child: FlatButton(
                                                    padding: EdgeInsets.all(20),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                    color: Colors.grey.shade100,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.favorite,
                                                          color:
                                                              Color(0xffF9813A),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "Favorite",
                                                            style: GoogleFonts.inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        Icon(Icons
                                                            .arrow_forward_ios),
                                                      ],
                                                    ),
                                                    onPressed: () =>
                                                        Get.toNamed(
                                                            Routes.FAVORITE),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : data['role'] == 'Seller'
                                              ? Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 30,
                                                          vertical: 10),
                                                      child: FlatButton(
                                                        padding:
                                                            EdgeInsets.all(15),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        color: Colors.white60,
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons
                                                                .edit_attributes),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                "Edit your petshop",
                                                                style: GoogleFonts.inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ),
                                                            Icon(Icons
                                                                .arrow_forward_ios),
                                                          ],
                                                        ),
                                                        onPressed: () =>
                                                            Get.toNamed(Routes
                                                                .ADD_PETSHOP),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 30,
                                                          vertical: 10),
                                                      child: FlatButton(
                                                        padding:
                                                            EdgeInsets.all(15),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        color: Colors.white60,
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons
                                                                .emoji_people),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                "Go Back As User",
                                                                style: GoogleFonts.inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ),
                                                            Icon(Icons
                                                                .arrow_forward_ios),
                                                          ],
                                                        ),
                                                        onPressed: () =>
                                                            profileController
                                                                .changeRoleToMember(
                                                                    userId),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : SizedBox(),
                              Container(
                                  height: height * 0.07,
                                  width: width * 0.4,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Icon(Icons.logout,
                                              size: 19,
                                              color: data['role'] == 'Member'
                                                  ? Color(0xffF9813A)
                                                  : Color(0xff2596BE)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text("Log Out",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'SanFrancisco.Regular',
                                                      fontSize: 14,
                                                      color: data['role'] ==
                                                              'Member'
                                                          ? Color(0xffF9813A)
                                                          : Color(0xff2596BE))),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        Get.dialog(AlertDialog(
                                          title: Text(
                                            'Alert',
                                            style: TextStyle(
                                                fontFamily: 'SanFrancisco',
                                                fontSize: 14),
                                          ),
                                          titlePadding: EdgeInsets.only(
                                              left: 26, right: 26, top: 30),
                                          contentPadding: EdgeInsets.only(
                                              left: 26,
                                              right: 26,
                                              top: 16,
                                              bottom: 12),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          content: Text(
                                              'Are you sure want to logout?',
                                              style: TextStyle(
                                                  fontFamily:
                                                      'SanFrancisco.Light',
                                                  fontSize: 12)),
                                          actionsPadding: EdgeInsets.only(
                                              right: 12, top: 6, bottom: 2),
                                          actions: [
                                            TextButton(
                                                onPressed: () => {Get.back()},
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'SanFrancisco.Light',
                                                      fontSize: 13,
                                                      color: Colors.orange),
                                                )),
                                            TextButton(
                                                onPressed: () => {
                                                      Get.back(),
                                                      authController.logout()
                                                    },
                                                child: Text(
                                                  'Log Out',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'SanFrancisco',
                                                      fontSize: 13,
                                                      color: Colors.orange),
                                                )),
                                          ],
                                        ));
                                      },
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
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

    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
