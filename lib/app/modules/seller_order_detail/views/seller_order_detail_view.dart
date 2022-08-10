import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/seller_order_detail/views/seller_detail_on_going.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import 'package:money_formatter/money_formatter.dart';

import '../controllers/seller_order_detail_controller.dart';

final reasons = TextEditingController();

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
            style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 15),
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
                } else if (data['status'] == 'On Going') {
                  return SellerOnGoing();
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
    dynamic arguments = Get.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getOrder(Get.arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data() as Map<String, dynamic>;

                var bookingType = data['bookingType'];
                localStorage.write('petshopId', Get.arguments);

                return FutureBuilder<DocumentSnapshot<Object?>>(
                    future: bookingType == 'Grooming Service'
                        ? controller.getPackage(data['packageId'])
                        : bookingType == 'Vet Service'
                            ? controller.getSession(data['sessionId'])
                            : controller.getRoom(data['roomId']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        var packageData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        double bookingFee = 5000;
                        double charge = 0;
                        double tax = 0;
                        if (bookingType == 'Vet Service') {
                          if (data['isDelivery'] == false) {
                            charge = bookingFee;
                          } else {
                            charge = bookingFee + data['deliveryFee'];
                          }
                        } else {
                          tax = double.parse(packageData['price']) * 10 / 100;
                          charge = 0;
                          if (data['isDelivery'] == false) {
                            charge = double.parse(packageData['price']) +
                                bookingFee +
                                tax;
                          } else {
                            charge = double.parse(packageData['price']) +
                                bookingFee +
                                tax +
                                data['deliveryFee'];
                          }
                        }
                        MoneyFormatter fmf = MoneyFormatter(
                            amount: charge,
                            settings: MoneyFormatterSettings(
                              symbol: 'Rp.',
                              thousandSeparator: '.',
                              decimalSeparator: ',',
                              symbolAndNumberSeparator: ' ',
                            ));
                        MoneyFormatterOutput fo = fmf.output;

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
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'SanFrancisco',
                                        color: Color(0xff2596BE),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Center(
                                      child: Container(
                                        height: height * 0.11,
                                        width: width * 0.9,
                                        decoration: BoxDecoration(
                                            color: Color(0xff2596BE),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade300,
                                                  spreadRadius: 3,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 3))
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Order ID',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'SanFrancisco.Light',
                                                          color: Colors.white)),
                                                  Text(
                                                      "#${arguments.toString().toUpperCase()}",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'SanFrancisco',
                                                          color: Colors.white)),
                                                ],
                                              ),
                                              Spacer(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Status',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'SanFrancisco.Light',
                                                          color: Colors.white)),
                                                  Text(data['status'],
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'SanFrancisco',
                                                          color: Colors.white)),
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
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'SanFrancisco',
                                        color: Color(0xff2596BE),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Center(
                                      child: Container(
                                        height: height * 0.62,
                                        width: width * 0.9,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Service',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily:
                                                          'SanFrancisco',
                                                      color: Colors.black)),
                                              const Divider(
                                                thickness: 1,
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              bookingType == 'Grooming Service'
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text('Service type',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'SanFrancisco.Light',
                                                                color: Colors
                                                                    .grey
                                                                    .shade700)),
                                                        Text(
                                                            data['serviceType'],
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'SanFrancisco',
                                                                color: Colors
                                                                    .grey
                                                                    .shade600)),
                                                      ],
                                                    )
                                                  : bookingType == 'Pet Hotel'
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('Service Type',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'SanFrancisco.Light',
                                                                    color: Colors
                                                                        .grey
                                                                        .shade700)),
                                                            Text('Pet Hotel',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'SanFrancisco',
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600)),
                                                          ],
                                                        )
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('Service Type',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'SanFrancisco.Light',
                                                                    color: Colors
                                                                        .grey
                                                                        .shade700)),
                                                            Text('Vet Service',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'SanFrancisco',
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600)),
                                                          ],
                                                        ),
                                              Spacer(),
                                              bookingType == 'Grooming Service'
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text('Service package',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'SanFrancisco.Light',
                                                                color: Colors
                                                                    .grey
                                                                    .shade700)),
                                                        Text(
                                                            'Full Service Grooming',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'SanFrancisco',
                                                                color: Colors
                                                                    .grey
                                                                    .shade600)),
                                                      ],
                                                    )
                                                  : bookingType == 'Vet'
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('Session',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'SanFrancisco.Light',
                                                                    color: Colors
                                                                        .grey
                                                                        .shade700)),
                                                            Text(
                                                                packageData[
                                                                    'number'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'SanFrancisco',
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600)),
                                                          ],
                                                        )
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('Room',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'SanFrancisco.Light',
                                                                    color: Colors
                                                                        .grey
                                                                        .shade700)),
                                                            Text(
                                                                packageData[
                                                                    'name'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'SanFrancisco',
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600)),
                                                          ],
                                                        ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () => {
                                                  Get.toNamed(
                                                      Routes.ADDITIONAL_INFO,
                                                      arguments: 2),
                                                  localStorage.write(
                                                      'petInfoId',
                                                      data['petId'])
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('Pet ID',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'SanFrancisco.Light',
                                                            color: Colors.grey
                                                                .shade700)),
                                                    Row(
                                                      children: [
                                                        Text(
                                                            "#${data['petId'].toString().toUpperCase()}",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'SanFrancisco',
                                                                color: Color(
                                                                    0xff2596BE))),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Icon(
                                                          Icons.info,
                                                          size: 15,
                                                          color:
                                                              Color(0xff2596BE),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () => {
                                                  Get.toNamed(
                                                      Routes.ADDITIONAL_INFO,
                                                      arguments: 1)
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('Delivery Option',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'SanFrancisco.Light',
                                                            color: Colors.grey
                                                                .shade700)),
                                                    data['isDelivery'] == true
                                                        ? Row(
                                                            children: [
                                                              Text(
                                                                  "Pick Up & Delivery",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          'SanFrancisco',
                                                                      color: Color(
                                                                          0xff2596BE))),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Icon(
                                                                Icons.info,
                                                                size: 15,
                                                                color: Color(
                                                                    0xff2596BE),
                                                              )
                                                            ],
                                                          )
                                                        : Row(
                                                            children: [
                                                              Text(
                                                                  "Without Delivery",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          'SanFrancisco',
                                                                      color: Colors
                                                                          .grey
                                                                          .shade600)),
                                                            ],
                                                          )
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Booking from',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'SanFrancisco.Light',
                                                          color: Colors
                                                              .grey.shade700)),
                                                  Text('Petshop A',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'SanFrancisco',
                                                          color: Colors
                                                              .grey.shade600)),
                                                ],
                                              ),
                                              Spacer(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Booking created',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'SanFrancisco.Light',
                                                          color: Colors
                                                              .grey.shade700)),
                                                  Text(data['orderCreated'],
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'SanFrancisco',
                                                          color: Colors
                                                              .grey.shade600)),
                                                ],
                                              ),
                                              Spacer(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Booking appointment',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'SanFrancisco.Light',
                                                          color: Colors
                                                              .grey.shade700)),
                                                  Text(
                                                      data['orderDate']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'SanFrancisco',
                                                          color: Colors
                                                              .grey.shade600)),
                                                ],
                                              ),
                                              Spacer(),
                                              bookingType == 'Grooming Service'
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text('Booking time',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'SanFrancisco.Light',
                                                                color: Colors
                                                                    .grey
                                                                    .shade700)),
                                                        Text("12.00 PM",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'SanFrancisco',
                                                                color: Colors
                                                                    .grey
                                                                    .shade600)),
                                                      ],
                                                    )
                                                  : SizedBox(
                                                      height: 1,
                                                    ),
                                              bookingType == 'Vet'
                                                  ? SizedBox(
                                                      height: 6,
                                                    )
                                                  : bookingType ==
                                                          'Grooming Service'
                                                      ? Spacer()
                                                      : SizedBox(),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Spacer(),
                                              Text('Charge',
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15,
                                                      color: Colors.black)),
                                              const Divider(
                                                thickness: 1,
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Service charge',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'SanFrancisco.Light',
                                                          color: Colors
                                                              .grey.shade700)),
                                                  Text(
                                                      "Rp. ${packageData['price']}",
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors
                                                              .grey.shade500)),
                                                ],
                                              ),
                                              Spacer(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Booking fee',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'SanFrancisco.Light',
                                                          color: Colors
                                                              .grey.shade700)),
                                                  Text(
                                                      "Rp. ${bookingFee.toString()}",
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors
                                                              .grey.shade500)),
                                                ],
                                              ),
                                              Spacer(),
                                              data['isDelivery'] == true
                                                  ? Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('Delivery fee',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'SanFrancisco.Light',
                                                                    color: Colors
                                                                        .grey
                                                                        .shade700)),
                                                            Text(
                                                                "Rp. ${data['deliveryFee']}",
                                                                style: GoogleFonts.roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500)),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 14,
                                                        )
                                                      ],
                                                    )
                                                  : SizedBox(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Tax',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'SanFrancisco.Light',
                                                          color: Colors
                                                              .grey.shade700)),
                                                  Text("Rp. ${tax.toString()}",
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                          color: Colors
                                                              .grey.shade500)),
                                                ],
                                              ),
                                              Spacer(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Total charge',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'SanFrancisco',
                                                          color: Colors
                                                              .grey.shade700)),
                                                  Text(fo.symbolOnLeft,
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 14,
                                                          color: Color(
                                                              0xff2596BE))),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
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
