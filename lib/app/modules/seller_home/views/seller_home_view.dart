import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';
import 'package:halopet_beta/app/modules/profile/views/profile_view.dart';
import 'package:halopet_beta/app/modules/seller_history/views/seller_history_view.dart';
import 'package:halopet_beta/app/modules/seller_order_detail/controllers/seller_order_detail_controller.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/seller_home_controller.dart';

final reasons = TextEditingController();

class SellerHomeView extends GetView<SellerHomeController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final authController = Get.find<AuthController>();
  final homeController = Get.put(SellerHomeController());

  void indexAction(int index) {
    homeController.index.value = index;
  }

  List<Widget> containerList = [
    ApprovalContainer(),
    PaymentContainer(),
    OnGoingContainer(),
    CompletedContainer(),
    CancelledContainer()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(
              child: Text(
            'Booking Order',
            style: TextStyle(
              fontFamily: 'SanFrancisco',
              fontSize: 15,
            ),
          )),
          backgroundColor: Color(0xff2596BE),
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () => Get.toNamed(Routes.PROFILE),
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => authController.logout(),
            ),
          ],
          bottom: const TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  text: "Waiting for Approval",
                ),
                Tab(
                  text: "Waiting for Payment",
                ),
                Tab(
                  text: "On Going",
                ),
                Tab(
                  text: "Completed",
                ),
                Tab(
                  text: "Cancelled",
                )
              ]),
        ),
        body: TabBarView(
          children: containerList,
        ),
      ),
    );
  }
}

class ApprovalContainer extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final homeController = Get.put(SellerHomeController());
  final orderController = Get.put(SellerOrderDetailController());
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var userId = localStorage.read('currentUserId');
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: homeController.getUser(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              var petshopId = data['petshopId'];
              return StreamBuilder<QuerySnapshot<Object?>>(
                  stream: homeController.getByApprovalStatus(petshopId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var data = snapshot.data!.docs;
                      return ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var dataMap =
                              data[index].data() as Map<String, dynamic>;
                          return Container(
                            height: height * 0.21,
                            width: width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade200,
                                ),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 16, bottom: 16, right: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(" ${dataMap['bookingType']} ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey.shade800,
                                                  fontFamily: 'SanFrancisco')),
                                        ],
                                      ),
                                      Container(
                                        height: height * 0.026,
                                        width: width * 0.4,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade300,
                                                spreadRadius: 0.5,
                                                blurRadius: 0.5,
                                                offset: Offset(0, 1))
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Center(
                                            child: Text('Waiting for Approval',
                                                style: TextStyle(
                                                    color: Color(0xff2596BE),
                                                    fontSize: 10,
                                                    fontFamily:
                                                        'SanFrancisco'))),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  SizedBox(
                                    width: width * 0.8,
                                    height: height * 0.02,
                                    child: Container(
                                        width: width * 0.8,
                                        height: height * 0.04,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text('  Order ID',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey.shade800,
                                                    fontFamily:
                                                        'SanFrancisco')),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                                "#${data[index].id.toUpperCase()}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color(0xff2596BE),
                                                    fontSize: 13,
                                                    fontFamily: 'SanFrancisco'))
                                          ],
                                        )),
                                  ),
                                  Container(
                                    height: height * 0.04,
                                    child: TextButton(
                                      onPressed: () => {
                                        localStorage.write('petshopId',
                                            data[index]['petshopId']),
                                        Get.toNamed(Routes.SELLER_ORDER_DETAIL,
                                            arguments: data[index].id)
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'See details ',
                                            style: TextStyle(
                                                color: Color(0xff2596BE),
                                                fontSize: 12,
                                                fontFamily: 'SanFrancisco'),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            size: 14,
                                            color: Color(0xff2596BE),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                      width: width * 0.9,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: size.height * 0.05,
                                                width: size.width * 0.25,
                                                color: Colors.transparent,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0,
                                                          vertical: 5.0),
                                                      primary:
                                                          Colors.grey.shade100,
                                                      shape: StadiumBorder(),
                                                    ),
                                                    onPressed: () => {
                                                          Get.dialog(
                                                              AlertDialog(
                                                            title: Text(
                                                              'Booking Confirmation',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'SanFrancisco',
                                                                  fontSize: 14),
                                                            ),
                                                            titlePadding:
                                                                EdgeInsets.only(
                                                                    left: 26,
                                                                    right: 26,
                                                                    top: 30),
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                              left: 26,
                                                              right: 26,
                                                              top: 12,
                                                            ),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            content: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          12.0),
                                                              child:
                                                                  TextFormField(
                                                                decoration: InputDecoration(
                                                                    border: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(
                                                                                20))),
                                                                    labelText:
                                                                        "Cancellation Reason*",
                                                                    hintText:
                                                                        'Reason',
                                                                    hintStyle: TextStyle(
                                                                        fontFamily:
                                                                            'SanFrancisco.Light',
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600),
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            18),
                                                                    floatingLabelBehavior:
                                                                        FloatingLabelBehavior
                                                                            .always),
                                                              ),
                                                            ),
                                                            actionsPadding:
                                                                EdgeInsets.only(
                                                                    right: 12,
                                                                    top: 6,
                                                                    bottom: 2),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () => {
                                                                            Get.back()
                                                                          },
                                                                  child: Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'SanFrancisco.Light',
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xff2596BE)),
                                                                  )),
                                                              TextButton(
                                                                  onPressed:
                                                                      () => {
                                                                            orderController.bookingCancellation(data[index].id,
                                                                                reasons.text)
                                                                          },
                                                                  child: Text(
                                                                    'Confirm',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'SanFrancisco',
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xff2596BE)),
                                                                  )),
                                                            ],
                                                          ))
                                                        },
                                                    child: Column(
                                                      children: const [
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Center(
                                                          child: Icon(
                                                            Icons.cancel,
                                                            size: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Center(
                                                          child: Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 11,
                                                                fontFamily:
                                                                    'SanFrancisco.Light'),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                height: size.height * 0.05,
                                                width: size.width * 0.25,
                                                color: Colors.transparent,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0,
                                                          vertical: 5.0),
                                                      primary: Colors.green,
                                                      shape: StadiumBorder(),
                                                    ),
                                                    onPressed: () => {
                                                          Get.dialog(
                                                              AlertDialog(
                                                            title: Text(
                                                              'Booking Confirmation',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'SanFrancisco',
                                                                  fontSize: 14),
                                                            ),
                                                            titlePadding:
                                                                EdgeInsets.only(
                                                                    left: 26,
                                                                    right: 26,
                                                                    top: 30),
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 26,
                                                                    right: 26,
                                                                    top: 16,
                                                                    bottom: 12),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            content: Text(
                                                                'Are you sure want to accept this booking?',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'SanFrancisco.Light',
                                                                    fontSize:
                                                                        12)),
                                                            actionsPadding:
                                                                EdgeInsets.only(
                                                                    right: 12,
                                                                    top: 6,
                                                                    bottom: 2),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () => {
                                                                            Get.back()
                                                                          },
                                                                  child: Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'SanFrancisco.Light',
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xff2596BE)),
                                                                  )),
                                                              TextButton(
                                                                  onPressed:
                                                                      () => {
                                                                            orderController.accepted(data[index].id)
                                                                          },
                                                                  child: Text(
                                                                    'Yes, accept this booking',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'SanFrancisco',
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xff2596BE)),
                                                                  )),
                                                            ],
                                                          ))
                                                        },
                                                    child: Column(
                                                      children: [
                                                        Center(
                                                          child: Icon(
                                                            Icons.done,
                                                            size: 14,
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Text(
                                                            'Accept',
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                fontFamily:
                                                                    'SanFrancisco'),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class PaymentContainer extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final homeController = Get.put(SellerHomeController());
  final orderController = Get.put(SellerOrderDetailController());
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var userId = localStorage.read('currentUserId');
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: homeController.getUser(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              var petshopId = data['petshopId'];
              return StreamBuilder<QuerySnapshot<Object?>>(
                  stream: homeController.getByPaymentStatus(petshopId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var data = snapshot.data!.docs;
                      return ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var dataMap =
                              data[index].data() as Map<String, dynamic>;
                          return InkWell(
                            onTap: () => {},
                            child: Container(
                              height: height * 0.21,
                              width: width,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.shade200,
                                  ),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 16, bottom: 16, right: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(' Grooming ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey.shade800,
                                                    fontFamily:
                                                        'SanFrancisco')),
                                            Text('Service',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'SanFrancisco.Light')),
                                          ],
                                        ),
                                        Container(
                                          height: height * 0.026,
                                          width: width * 0.4,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade300,
                                                  spreadRadius: 0.5,
                                                  blurRadius: 0.5,
                                                  offset: Offset(0, 1))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Center(
                                              child: Text('Waiting for Payment',
                                                  style: TextStyle(
                                                      color: Color(0xff2596BE),
                                                      fontSize: 10,
                                                      fontFamily:
                                                          'SanFrancisco'))),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    SizedBox(
                                      width: width * 0.8,
                                      height: height * 0.02,
                                      child: Container(
                                          width: width * 0.8,
                                          height: height * 0.04,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text('   Order ID',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontFamily:
                                                          'SanFrancisco')),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                  "#${data[index].id.toUpperCase()}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color(0xff2596BE),
                                                      fontSize: 13,
                                                      fontFamily:
                                                          'SanFrancisco'))
                                            ],
                                          )),
                                    ),
                                    Container(
                                      height: height * 0.04,
                                      child: TextButton(
                                        onPressed: () => {
                                          localStorage.write('petshopId',
                                              data[index]['petshopId']),
                                          Get.toNamed(
                                              Routes.SELLER_ORDER_DETAIL,
                                              arguments: data[index].id)
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              'See details ',
                                              style: TextStyle(
                                                  color: Color(0xff2596BE),
                                                  fontSize: 12,
                                                  fontFamily: 'SanFrancisco'),
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                              size: 15,
                                              color: Color(0xff2596BE),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                        width: width * 0.9,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: size.height * 0.05,
                                                  width: size.width * 0.5,
                                                  color: Colors.transparent,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    10.0,
                                                                vertical: 5.0),
                                                        primary: Colors
                                                            .grey.shade100,
                                                        shape: StadiumBorder(),
                                                      ),
                                                      onPressed: () => {
                                                            Get.dialog(
                                                                AlertDialog(
                                                              title: Text(
                                                                'Booking Cancellation',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'SanFrancisco',
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                              titlePadding:
                                                                  EdgeInsets.only(
                                                                      left: 26,
                                                                      right: 26,
                                                                      top: 30),
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: 26,
                                                                right: 26,
                                                                top: 12,
                                                              ),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              content: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            12.0),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      reasons,
                                                                  decoration: InputDecoration(
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              20))),
                                                                      labelText:
                                                                          "Cancellation Reason*",
                                                                      hintText:
                                                                          'Reason',
                                                                      hintStyle: TextStyle(
                                                                          fontFamily:
                                                                              'SanFrancisco.Light',
                                                                          fontSize:
                                                                              13,
                                                                          color: Colors
                                                                              .grey
                                                                              .shade600),
                                                                      contentPadding:
                                                                          EdgeInsets.all(
                                                                              18),
                                                                      floatingLabelBehavior:
                                                                          FloatingLabelBehavior
                                                                              .always),
                                                                ),
                                                              ),
                                                              actionsPadding:
                                                                  EdgeInsets.only(
                                                                      right: 12,
                                                                      top: 6,
                                                                      bottom:
                                                                          2),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () => {
                                                                              Get.back()
                                                                            },
                                                                    child: Text(
                                                                      'Cancel',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'SanFrancisco.Light',
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Color(0xff2596BE)),
                                                                    )),
                                                                TextButton(
                                                                    onPressed:
                                                                        () => {
                                                                              orderController.bookingCancellation(data[index].id, reasons.text)
                                                                            },
                                                                    child: Text(
                                                                      'Confirm',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'SanFrancisco',
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Color(0xff2596BE)),
                                                                    )),
                                                              ],
                                                            ))
                                                          },
                                                      child: Column(
                                                        children: const [
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Center(
                                                            child: Icon(
                                                              Icons.cancel,
                                                              size: 12,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Center(
                                                            child: Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 11,
                                                                  fontFamily:
                                                                      'SanFrancisco.Light'),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                ),
                                              ],
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class OnGoingContainer extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final homeController = Get.put(SellerHomeController());
  final orderController = Get.put(SellerOrderDetailController());
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var userId = localStorage.read('currentUserId');
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: homeController.getUser(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              var petshopId = data['petshopId'];
              return StreamBuilder<QuerySnapshot<Object?>>(
                  stream: homeController.getByOnGoing(petshopId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var data = snapshot.data!.docs;
                      return ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var dataMap =
                              data[index].data() as Map<String, dynamic>;
                          return InkWell(
                            onTap: () => {},
                            child: Container(
                              height: height * 0.2,
                              width: width,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.shade200,
                                  ),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 16, bottom: 16, right: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(' Grooming ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey.shade800,
                                                    fontFamily:
                                                        'SanFrancisco')),
                                            Text('Service',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'SanFrancisco.Light')),
                                          ],
                                        ),
                                        Container(
                                          height: height * 0.026,
                                          width: width * 0.4,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade300,
                                                  spreadRadius: 0.5,
                                                  blurRadius: 0.5,
                                                  offset: Offset(0, 1))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Center(
                                              child: Text('On Going',
                                                  style: TextStyle(
                                                      color: Color(0xff2596BE),
                                                      fontSize: 10,
                                                      fontFamily:
                                                          'SanFrancisco'))),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    SizedBox(
                                      width: width * 0.8,
                                      height: height * 0.02,
                                      child: Container(
                                          width: width * 0.8,
                                          height: height * 0.04,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text('   Order ID',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontFamily:
                                                          'SanFrancisco')),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                  "#${data[index].id.toUpperCase()}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color(0xff2596BE),
                                                      fontSize: 13,
                                                      fontFamily:
                                                          'SanFrancisco'))
                                            ],
                                          )),
                                    ),
                                    Container(
                                      height: height * 0.04,
                                      child: TextButton(
                                        onPressed: () => {
                                          localStorage.write('petshopId',
                                              data[index]['petshopId']),
                                          Get.toNamed(
                                              Routes.SELLER_ORDER_DETAIL,
                                              arguments: data[index].id)
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              'See details ',
                                              style: TextStyle(
                                                  color: Color(0xff2596BE),
                                                  fontSize: 12,
                                                  fontFamily: 'SanFrancisco'),
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                              size: 15,
                                              color: Color(0xff2596BE),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                        width: width * 0.9,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: size.height * 0.04,
                                                  width: size.width * 0.5,
                                                  color: Colors.transparent,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors
                                                            .grey.shade100,
                                                      ),
                                                      onPressed: () => {},
                                                      child: Center(
                                                        child: Text(
                                                          'Booking Created',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'SanFrancisco.Light'),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class CompletedContainer extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final homeController = Get.put(SellerHomeController());
  final orderController = Get.put(SellerOrderDetailController());
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var userId = localStorage.read('currentUserId');
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: homeController.getUser(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              var petshopId = data['petshopId'];
              return StreamBuilder<QuerySnapshot<Object?>>(
                  stream: homeController.getByCompleted(petshopId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var data = snapshot.data!.docs;
                      return ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var dataMap =
                              data[index].data() as Map<String, dynamic>;
                          return InkWell(
                            onTap: () => {},
                            child: Container(
                              height: height * 0.2,
                              width: width,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.shade200,
                                  ),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 16, bottom: 16, right: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(' Grooming ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey.shade800,
                                                    fontFamily:
                                                        'SanFrancisco')),
                                            Text('Service',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'SanFrancisco.Light')),
                                          ],
                                        ),
                                        Container(
                                          height: height * 0.026,
                                          width: width * 0.4,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade300,
                                                  spreadRadius: 0.5,
                                                  blurRadius: 0.5,
                                                  offset: Offset(0, 1))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Center(
                                              child: Text('Completed',
                                                  style: TextStyle(
                                                      color: Color(0xff2596BE),
                                                      fontSize: 10,
                                                      fontFamily:
                                                          'SanFrancisco'))),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    SizedBox(
                                      width: width * 0.8,
                                      height: height * 0.02,
                                      child: Container(
                                          width: width * 0.8,
                                          height: height * 0.04,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text('   Order ID',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontFamily:
                                                          'SanFrancisco')),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                  "#${data[index].id.toUpperCase()}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color(0xff2596BE),
                                                      fontSize: 13,
                                                      fontFamily:
                                                          'SanFrancisco'))
                                            ],
                                          )),
                                    ),
                                    Container(
                                      height: height * 0.04,
                                      child: TextButton(
                                        onPressed: () => {
                                          localStorage.write('petshopId',
                                              data[index]['petshopId']),
                                          Get.toNamed(
                                              Routes.SELLER_ORDER_DETAIL,
                                              arguments: data[index].id)
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              'See details ',
                                              style: TextStyle(
                                                  color: Color(0xff2596BE),
                                                  fontSize: 12,
                                                  fontFamily: 'SanFrancisco'),
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                              size: 15,
                                              color: Color(0xff2596BE),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                        width: width * 0.9,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: size.height * 0.04,
                                                  width: size.width * 0.5,
                                                  color: Colors.transparent,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors
                                                            .grey.shade100,
                                                      ),
                                                      onPressed: () => {},
                                                      child: Center(
                                                        child: Text(
                                                          'Completed',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'SanFrancisco.Light'),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class CancelledContainer extends StatefulWidget {
  const CancelledContainer({Key? key}) : super(key: key);

  @override
  _CancelledContainerState createState() => _CancelledContainerState();
}

class _CancelledContainerState extends State<CancelledContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
