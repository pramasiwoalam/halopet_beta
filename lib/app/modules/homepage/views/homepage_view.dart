import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';
import 'package:halopet_beta/app/modules/history/views/history_view.dart';
import 'package:halopet_beta/app/modules/order/views/order_view.dart';
import 'package:halopet_beta/app/modules/profile/views/profile_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/homepage_controller.dart';

class HomepageView extends GetView<HomepageController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final authController = Get.find<AuthController>();
  final homeController = Get.put(HomepageController());
  final localStorage = GetStorage();

  void indexAction(int index) {
    homeController.index.value = index;
  }

  final tabs = [Home(), OrderView(), HistoryView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => tabs[homeController.index.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: homeController.index.value,
          iconSize: 33,
          unselectedFontSize: 10,
          selectedFontSize: 15,
          selectedItemColor: Color(0xffF9813A),
          showSelectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                label: "Home",
                icon: Icon(
                  Icons.home,
                  color: Color(0xffF9813A),
                ),
                backgroundColor: Color(0xfff2f2f2)),
            BottomNavigationBarItem(
                label: "Order",
                icon: Icon(
                  Icons.book,
                  color: Color(0xffF9813A),
                ),
                backgroundColor: Color(0xfff2f2f2)),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.history_edu,
                  color: Color(0xffF9813A),
                ),
                label: "History",
                backgroundColor: Color(0xfff2f2f2)),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Color(0xffF9813A),
                ),
                label: "Profile",
                backgroundColor: Color(0xfff2f2f2)),
          ],
          onTap: (index) {
            indexAction(index);
          },
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final homeController = Get.put(HomepageController());
  final localStorage = GetStorage();

  var cards = [
    {
      'name': 'Grooming Service',
      'image': 'assets/images/grooming-card.jpg',
      'value': 1
    },
    {
      'name': 'Vet Available',
      'image': 'assets/images/vet-card.jpg',
      'value': 2
    },
    {'name': 'Pet Hotel', 'image': 'assets/images/hotel-card.jpg', 'value': 3},
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var userId = localStorage.read('userId');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future:
              homeController.getUserById(localStorage.read('currentUserId')),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              localStorage.write('favArr', data['favoriteId']);

              return StreamBuilder<QuerySnapshot<Object?>>(
                  stream: homeController.getFavByUserId(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var favData = snapshot.data!.docs;
                      var arrData = [];
                      // favData.forEach((element) => arrData.add([
                      //       {'favId': element.id.toString()},
                      //     ]));
                      // print('arr: ${arrData}');
                      // localStorage.write('favArr', arrData);
                      return Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: SafeArea(
                          child: ListView(
                            physics: const ClampingScrollPhysics(),
                            children: <Widget>[
                              Container(
                                height: height / 7,
                                width: width / 2,
                                // color: Colors.lightBlue,
                                margin: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        // color: Colors.red,
                                        margin: EdgeInsets.only(
                                            left: width * 0.05,
                                            top: height * 0.03),
                                        height: height / 5,
                                        width: width / 2,
                                        // color: Colors.black,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Hello,',
                                              style: GoogleFonts.inter(
                                                  color: Color(0xffF9813A),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '${data["name"]}',
                                              style: GoogleFonts.inter(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_pin,
                                                    size: 17,
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    'Jakarta, Indonesia',
                                                    style: GoogleFonts.inter(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: width * 0.04,
                                          top: height * 0.01,
                                          bottom: height * 0.005),
                                      height: height / 4,
                                      width: width / 4,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/user.png')),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: height * 0.01,
                                    right: width * 0.07,
                                    left: width * 0.07),
                                height: height * 0.05,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Find Petshop by Services',
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                              Container(
                                height: height * 0.2,
                                width: width * 0.1,
                                // color: Colors.black,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding:
                                        EdgeInsets.only(left: 15, right: 5),
                                    itemCount: cards.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () => Get.toNamed(
                                            Routes.CATEGORY_PAGE,
                                            arguments: cards[index]['value']),
                                        child: Container(
                                          height: height * 0.2,
                                          width: width * 0.4,
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      '${cards[index]['image']}')),
                                              border: Border.all(
                                                  width: 1.8,
                                                  color:
                                                      const Color(0xfff0f0f0)),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0xfff0f0f0),
                                                  spreadRadius: 0.1,
                                                  blurRadius: 0.8,
                                                )
                                              ]),

                                          // child: Align(
                                          //   alignment: Alignment.center,
                                          //   child: Text('${cards[index]['name']}'),
                                          // ),
                                        ),
                                      );
                                    }),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: height * 0.01,
                                    right: width * 0.07,
                                    left: width * 0.07),
                                height: height * 0.05,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Explore More',
                                          style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    InkWell(
                                      onTap: () => Get.toNamed(Routes.HISTORY),
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'See All',
                                            style: GoogleFonts.inter(
                                                fontSize: 14,
                                                color: Colors.lightBlue,
                                                fontWeight: FontWeight.w500),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              StreamBuilder<QuerySnapshot<Object?>>(
                                  stream: homeController.streamData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.active) {
                                      var data = snapshot.data!.docs;
                                      return Container(
                                        height: height * 0.28,
                                        child: ListView.builder(
                                            // physics: ClampingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 7, top: 1, right: 10),
                                                child: InkWell(
                                                  onTap: () => {
                                                    Get.toNamed(
                                                      Routes.PETSHOP_DETAIL,
                                                    ),
                                                    localStorage.write(
                                                        'petshopId',
                                                        data[index].id)
                                                  },
                                                  child: Container(
                                                    width: width * 0.40,
                                                    height: height * 0.1,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFf2f2f2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: const Color(
                                                              0xFFdedede)),
                                                    ),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      children: [
                                                        Positioned(
                                                          bottom: 14,
                                                          child: Container(
                                                            // color: Colors.red,
                                                            height:
                                                                height * 0.1,
                                                            width: width * 0.34,
                                                            decoration:
                                                                BoxDecoration(
                                                                    // color: Colors.blue,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: 13,
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '${(data[index].data() as Map<String, dynamic>)["petshopName"]}',
                                                                    style: GoogleFonts.inter(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  Text(
                                                                    '${(data[index].data() as Map<String, dynamic>)["petshopAddress"]}',
                                                                    style: GoogleFonts.inter(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        fontSize:
                                                                            12),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Stack(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                child: Image(
                                                                  height:
                                                                      height *
                                                                          0.17,
                                                                  width: width *
                                                                      0.38,
                                                                  image: const AssetImage(
                                                                      'assets/images/petshop-1.jpg'),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                              Container(
                                margin: EdgeInsets.only(
                                    top: height * 0.01,
                                    right: width * 0.07,
                                    left: width * 0.07),
                                height: height * 0.05,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Petshop Near You',
                                          style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    InkWell(
                                      onTap: () => Get.toNamed(Routes.HISTORY),
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'See All',
                                            style: GoogleFonts.inter(
                                                fontSize: 14,
                                                color: Colors.lightBlue,
                                                fontWeight: FontWeight.w500),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              StreamBuilder<QuerySnapshot<Object?>>(
                                  stream: homeController.streamData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.active) {
                                      var data = snapshot.data!.docs;
                                      return Container(
                                        height: height * 0.28,
                                        child: ListView.builder(
                                            // physics: ClampingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 7, top: 1, right: 10),
                                                child: InkWell(
                                                  onTap: () => Get.toNamed(
                                                      Routes.PETSHOP_DETAIL,
                                                      arguments:
                                                          data[index].id),
                                                  child: Container(
                                                    width: width * 0.40,
                                                    height: height * 0.1,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFf2f2f2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: const Color(
                                                              0xFFdedede)),
                                                    ),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      children: [
                                                        Positioned(
                                                          bottom: 14,
                                                          child: Container(
                                                            // color: Colors.red,
                                                            height:
                                                                height * 0.1,
                                                            width: width * 0.34,
                                                            decoration:
                                                                BoxDecoration(
                                                                    // color: Colors.blue,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: 13,
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '${(data[index].data() as Map<String, dynamic>)["petshopName"]}',
                                                                    style: GoogleFonts.inter(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  Text(
                                                                    '${(data[index].data() as Map<String, dynamic>)["petshopAddress"]}',
                                                                    style: GoogleFonts.inter(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        fontSize:
                                                                            12),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Stack(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                child: Image(
                                                                  height:
                                                                      height *
                                                                          0.17,
                                                                  width: width *
                                                                      0.38,
                                                                  image: const AssetImage(
                                                                      'assets/images/petshop-2.jpg'),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
