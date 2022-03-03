import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/seller_order_detail_controller.dart';

class SellerOrderDetailView extends GetView<SellerOrderDetailController> {
  final localStorage = GetStorage();
  final messageC = TextEditingController();
  RxBool isDeclined = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Booking Detail',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          backgroundColor: Color(0xff2596BE),
          elevation: 0,
        ),
        body: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getOrder(Get.arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                if (data['status'] == 'Waiting for approval') {
                  return WaitingApproval();
                } else if (data['status'] == 'Booking Created') {
                  return BookCreated();
                } else if (data['status'] == 'Declined') {
                  return Declined();
                } else if (data['status'] == 'Completed') {
                  return Declined();
                } else {
                  return SizedBox();
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}

class WaitingApproval extends GetView<SellerOrderDetailController> {
  final localStorage = GetStorage();
  final messageC = TextEditingController();
  RxBool isDeclined = false.obs;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getOrder(Get.arguments),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              var currentUserId = localStorage.read('currentUserId');
              var orderId = Get.arguments;
              localStorage.write('petshopId', Get.arguments);
              return Stack(
                children: [
                  Container(
                    height: height / 2,
                    width: width,
                    color: Colors.orange,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: height / 3),
                      height: height,
                      width: width,
                      color: Colors.red)
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class BookCreated extends GetView<SellerOrderDetailController> {
  final localStorage = GetStorage();
  final messageC = TextEditingController();
  RxBool isDeclined = false.obs;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getOrder(Get.arguments),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              var currentUserId = localStorage.read('currentUserId');
              var orderId = Get.arguments;
              localStorage.write('petshopId', Get.arguments);
              return Stack(
                children: [
                  Container(
                    height: height / 4,
                    width: width,
                    color: Color(0xff2596BE),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    height: height,
                    width: width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '   Order Detail',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: Color(0xff2596BE)),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: Container(
                              height: height * 0.13,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  color: Color(0xff2596BE),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        spreadRadius: 3,
                                        blurRadius: 5,
                                        offset: Offset(0, 3))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Order ID',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Colors.white)),
                                        Text('TR0018ASDJ2',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.white))
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Status',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Colors.white)),
                                        Text('Waiting for Approval',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.white))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Text(
                            '   Service Detail',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: Color(0xff2596BE)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Container(
                              height: height * 0.3,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: Offset(0, 2))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Order ID',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Color(0xff2596BE))),
                                        Text('TR0018ASDJ2',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: Color(0xff2596BE)))
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Order ID',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15)),
                                        Text('TR0018ASDJ2',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16))
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Order ID',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15)),
                                        Text('TR0018ASDJ2',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () => Get.toNamed(Routes.SELLER_PROFILE),
                              child: Container(
                                margin: EdgeInsets.only(top: height * 0.025),
                                width: width * 0.82,
                                height: height * 0.07,
                                decoration: BoxDecoration(
                                    color: Color(0xff2596BE),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          spreadRadius: 3,
                                          blurRadius: 4,
                                          offset: Offset(0, 4))
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 30, right: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Accept Booking',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                                color: Colors.white)),
                                        const Icon(
                                          Icons.done,
                                          size: 28,
                                          color: Colors.white,
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(top: height * 0.025),
                                width: width * 0.82,
                                height: height * 0.07,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          spreadRadius: 3,
                                          blurRadius: 4,
                                          offset: Offset(0, 4))
                                    ],
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 30, right: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Decline Booking',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                                color: Color(0xff2596BE))),
                                        const Icon(
                                          Icons.arrow_forward,
                                          color: Color(0xff2596BE),
                                          size: 26,
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class Declined extends GetView<SellerOrderDetailController> {
  final localStorage = GetStorage();
  final messageC = TextEditingController();
  RxBool isDeclined = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getOrder(Get.arguments),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              var currentUserId = localStorage.read('currentUserId');
              var orderId = Get.arguments;
              localStorage.write('petshopId', Get.arguments);
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Your Order Has Been Declined',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Cancellation Reason: ${data['message']}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ]);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
