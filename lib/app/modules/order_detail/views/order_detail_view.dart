import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import '../controllers/order_detail_controller.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Booking Detail',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
        ),
        body: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getOrder(Get.arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                if (data['status'] == 'Waiting for approval') {
                  return WaitingApproval();
                } else if (data['status'] == 'Waiting for payment') {
                  return WaitingPayment();
                } else if (data['status'] == 'Completed') {
                  return WaitingApproval();
                } else {
                  return SizedBox();
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}

class WaitingApproval extends GetView<OrderDetailController> {
  final localStorage = GetStorage();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    dynamic arguments = Get.arguments;

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getOrder(arguments),
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
                    color: Color(0xffF9813A),
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
                                fontSize: 18,
                                color: Color(0xffF9813A)),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: Container(
                              height: height * 0.13,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  color: Color(0xffF9813A),
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
                                                fontWeight: FontWeight.w400,
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
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15,
                                                color: Colors.white)),
                                        Text('Waiting for Approval',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                                color: Colors.white))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Text(
                            '   Service Detail',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Color(0xffF9813A)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Container(
                              height: height * 0.4,
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
                                    Text('Service',
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.grey.shade400)),
                                    const Divider(
                                      thickness: 1,
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Service type',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Colors.grey.shade500)),
                                        Text('Grooming',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Colors.grey.shade500))
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Service package',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Colors.grey.shade500)),
                                        Text('Full Service Grooming',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Colors.grey.shade500))
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Booking from',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Colors.grey.shade500)),
                                        Text('Dita Genday Petshop',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Colors.grey.shade500))
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Booking created',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Colors.grey.shade500)),
                                        Text('27 February 2022',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Colors.grey.shade500))
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Booking appointment',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Colors.grey.shade500)),
                                        Text('3 March 2022',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Colors.grey.shade500)),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Service charge',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Colors.grey.shade500)),
                                        Text('Rp. 100.000',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                                color: Color(0xffF9813A))),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(top: height * 0.03),
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
                                    color: Color(0xffF9813A),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 30, right: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Cancel Order Request',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                                color: Colors.white)),
                                        const Icon(
                                          Icons.cancel_schedule_send,
                                          color: Colors.white,
                                          size: 22,
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

class WaitingPayment extends GetView<OrderDetailController> {
  final localStorage = GetStorage();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    dynamic arguments = Get.arguments;

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getOrder(arguments),
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
                    color: Color(0xffF9813A),
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
                                color: Color(0xffF9813A)),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: Container(
                              height: height * 0.13,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  color: Color(0xffF9813A),
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
                          const SizedBox(
                            height: 18,
                          ),
                          Text(
                            '   Service Detail',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: Color(0xffF9813A)),
                          ),
                          const SizedBox(
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
                                                color: Color(0xffF9813A))),
                                        Text('TR0018ASDJ2',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: Color(0xffF9813A)))
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
                                    ),
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
                              onTap: () => Get.toNamed(Routes.HOMEPAGE),
                              child: Container(
                                margin: EdgeInsets.only(top: height * 0.025),
                                width: width * 0.82,
                                height: height * 0.07,
                                decoration: BoxDecoration(
                                    color: Color(0xffF9813A),
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
                                        Text('Proceed to Payment',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                                color: Colors.white)),
                                        const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 26,
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
                                        Text('Cancel Order',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                                color: Color(0xffF9813A))),
                                        const Icon(
                                          Icons.cancel_schedule_send,
                                          color: Color(0xffF9813A),
                                          size: 22,
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
