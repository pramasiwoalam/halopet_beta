import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';
import 'package:halopet_beta/app/modules/favorite/views/favorite_view.dart';
import 'package:halopet_beta/app/modules/order/views/order_view.dart';
import 'package:halopet_beta/app/modules/profile/views/profile_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/homepage_controller.dart';

final List<String> items = [
  'https://images.unsplash.com/photo-1607083206869-4c7672e72a8a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
  'https://images.unsplash.com/photo-1542992015-4a0b729b1385?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1489&q=80',
  'https://images.unsplash.com/photo-1572584642822-6f8de0243c93?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
];

class HomepageView extends GetView<HomepageController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final authController = Get.find<AuthController>();
  final homeController = Get.put(HomepageController());
  final localStorage = GetStorage();

  void indexAction(int index) {
    homeController.index.value = index;
  }

  final tabs = [Home(), OrderView(), FavoriteView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      body: Obx(() => tabs[homeController.index.value]),
      bottomNavigationBar: Obx(
        () => Container(
          height: height * 0.09,
          width: width,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                  color: Color.fromARGB(255, 121, 121, 121), width: 0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 224, 224, 224),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: homeController.index.value,
            iconSize: 28,
            unselectedFontSize: 10,
            selectedFontSize: 13,
            selectedItemColor: Color(0xffF9813A),
            showSelectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(
                    Icons.home,
                    color: Color(0xffF9813A),
                  ),
                  backgroundColor: Color.fromARGB(255, 255, 255, 255)),
              BottomNavigationBarItem(
                  label: "Order",
                  icon: Icon(
                    Icons.book,
                    color: Color(0xffF9813A),
                  ),
                  backgroundColor: Color.fromARGB(255, 255, 255, 255)),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: Color(0xffF9813A),
                  ),
                  label: "Favorite",
                  backgroundColor: Color.fromARGB(255, 255, 255, 255)),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Color(0xffF9813A),
                  ),
                  label: "Profile",
                  backgroundColor: Color.fromARGB(255, 255, 255, 255)),
            ],
            onTap: (index) {
              indexAction(index);
            },
          ),
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
    {'name': 'Grooming', 'value': 1},
    {'name': 'Vet', 'value': 2},
    {'name': 'Pet Hotel', 'value': 3},
    {'name': 'Information', 'value': 4},
    {'name': 'Vaccine', 'value': 5}
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var userId = localStorage.read('userId');

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder<DocumentSnapshot<Object?>>(
            future:
                homeController.getUserById(localStorage.read('currentUserId')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                if (data['favoriteId'] != null) {
                  localStorage.write('favArr', data['favoriteId']);
                } else {
                  localStorage.write('favArr', []);
                }
                return StreamBuilder<QuerySnapshot<Object?>>(
                    stream: homeController.getFavByUserId(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
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
                                      left: 16, right: 16, top: 10),
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
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                '${data["name"]}',
                                                style: GoogleFonts.inter(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
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
                                        height: height / 5,
                                        width: width / 5,
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
                                SizedBox(
                                  height: 12,
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                      bottom: 15,
                                    ),
                                    height: height * 0.22,
                                    width: width,
                                    child: CarouselSlider.builder(
                                      itemCount: items.length,
                                      options: CarouselOptions(
                                        disableCenter: false,
                                        autoPlay: true,
                                        autoPlayInterval: Duration(seconds: 2),
                                        // autoPlayCurve: Curves.fastOutSlowIn,

                                        aspectRatio: 16 / 9,
                                      ),
                                      itemBuilder: (context, index, realIdx) {
                                        return Container(
                                          child: Center(
                                              child: Image.network(items[index],
                                                  fit: BoxFit.cover,
                                                  width: 1000)),
                                        );
                                      },
                                    )),
                                Container(
                                  height: height * 0.08,
                                  width: width * 0.02,
                                  // color: Colors.black,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      padding:
                                          EdgeInsets.only(left: 20, right: 5),
                                      itemCount: cards.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () => Get.toNamed(
                                              Routes.CATEGORY_PAGE,
                                              arguments: cards[index]['value']),
                                          child: Container(
                                            height: height * 0.08,
                                            width: width * 0.16,

                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Color(0xffF9813A),
                                            ),
                                            margin: EdgeInsets.only(right: 15),
                                            child: Center(
                                                child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.pets,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  '${cards[index]['name']}',
                                                  style: GoogleFonts.roboto(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            )),

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
                                      right: width * 0.07,
                                      left: width * 0.07,
                                      top: 5),
                                  height: height * 0.05,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Explore More',
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          )),
                                      InkWell(
                                        onTap: () =>
                                            Get.toNamed(Routes.PETSHOP_LIST),
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'See All',
                                              style: GoogleFonts.inter(
                                                  fontSize: 13,
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
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Container(
                                            height: height * 0.28,
                                            child: ListView.builder(
                                                // physics: ClampingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: data.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 1, right: 15),
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
                                                        width: width * 0.42,
                                                        height: height * 0.1,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              245, 245, 245),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  230,
                                                                  230,
                                                                  230)),
                                                        ),
                                                        child: Stack(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          children: [
                                                            Positioned(
                                                              bottom: 7,
                                                              child: Container(
                                                                // color: Colors.red,
                                                                height: height *
                                                                    0.1,
                                                                width: width *
                                                                    0.37,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        // color: Colors.blue,
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
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
                                                                        style: GoogleFonts.roboto(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontSize: 13),
                                                                      ),
                                                                      Text(
                                                                        '${(data[index].data() as Map<String, dynamic>)["petshopAddress"]}',
                                                                        style: GoogleFonts.roboto(
                                                                            fontWeight:
                                                                                FontWeight.w300,
                                                                            fontSize: 11),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            7.0),
                                                                child: Stack(
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              3),
                                                                      child:
                                                                          Image(
                                                                        height: height *
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
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    }),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: width * 0.07, left: width * 0.07),
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
                                        onTap: () =>
                                            Get.toNamed(Routes.HISTORY),
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 7,
                                                          top: 1,
                                                          right: 10),
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
                                                            BorderRadius
                                                                .circular(20),
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
                                                              width:
                                                                  width * 0.34,
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
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    Text(
                                                                      '${(data[index].data() as Map<String, dynamic>)["petshopAddress"]}',
                                                                      style: GoogleFonts.inter(
                                                                          fontWeight: FontWeight
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
                                                                color: Colors
                                                                    .white,
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
                                                                    width:
                                                                        width *
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
                                        return const Center(
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
      ),
    );
  }
}

final List<Widget> imageSliders = items
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  ],
                )),
          ),
        ))
    .toList();
