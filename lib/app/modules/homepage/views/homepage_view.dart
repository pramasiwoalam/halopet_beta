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
          iconSize: 30,
          unselectedFontSize: 10,
          showSelectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: Text("Home"),
                backgroundColor: const Color(0xff8e10c4)),
            BottomNavigationBarItem(
                icon: Icon(Icons.book),
                title: Text("Order"),
                backgroundColor: const Color(0xff8e10c4)),
            BottomNavigationBarItem(
                icon: Icon(Icons.history_edu),
                title: Text("History"),
                backgroundColor: const Color(0xff8e10c4)),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
                backgroundColor: const Color(0xff8e10c4)),
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

  var cards = [
    {'name': 'Grooming Service', 'image': 'assets/images/grooming-card.jpg'},
    {'name': 'Pet Hotel', 'image': 'assets/images/hotel-card.jpg'},
    {'name': 'Vet Available', 'image': 'assets/images/vet-card.jpg'}
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: homeController.streamData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var data = snapshot.data!.docs;
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: SafeArea(
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: <Widget>[
                      Container(
                        height: height / 8,
                        width: width / 2,
                        // color: Colors.lightBlue,
                        margin:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    left: width * 0.05, top: height * 0.04),
                                height: height / 7,
                                width: width / 2,
                                // color: Colors.black,
                                child: Text(
                                  'Hello, \nPenjahat Kelamin!',
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                              margin: EdgeInsets.only(
                                  right: width * 0.04,
                                  top: height * 0.01,
                                  bottom: height * 0.005),
                              height: height / 4,
                              width: width / 4,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/user.png')),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: height * 0.03,
                            right: width * 0.07,
                            left: width * 0.07),
                        height: height * 0.05,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Find Petshop by Services',
                              style: GoogleFonts.inter(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            )),
                      ),
                      Container(
                        height: height * 0.2,
                        width: width * 0.1,
                        // color: Colors.black,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(left: 15, right: 5),
                            itemCount: cards.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Get.toNamed(Routes.HISTORY),
                                child: Container(
                                  height: height * 0.2,
                                  width: width * 0.4,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              '${cards[index]['image']}')),
                                      border: Border.all(
                                          width: 1.8,
                                          color: const Color(0xfff0f0f0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xfff0f0f0),
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
                            top: height * 0.015,
                            right: width * 0.07,
                            left: width * 0.07),
                        height: height * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Explore More',
                                  style: GoogleFonts.inter(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                )),
                            InkWell(
                              onTap: () => Get.toNamed(Routes.HISTORY),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'See All',
                                    style: GoogleFonts.inter(
                                        fontSize: 15,
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
                              return ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  // scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        elevation: 15,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: InkWell(
                                          onTap: () => Get.toNamed(
                                              Routes.PETSHOP_DETAIL,
                                              arguments: data[index].id),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Ink.image(
                                                height: 200,
                                                image: AssetImage(
                                                    'assets/images/petshop-1.jpg'),
                                                fit: BoxFit.fitWidth,
                                              ),
                                              ButtonBar(
                                                alignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 15, top: 5),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${(data[index].data() as Map<String, dynamic>)["petshopName"]}',
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          '${(data[index].data() as Map<String, dynamic>)["petshopAddress"]}',
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          }),
    );
  }
}
