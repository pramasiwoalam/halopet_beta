import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/order/views/order_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import 'package:money_formatter/money_formatter.dart';
import '../controllers/order_detail_controller.dart';

final reasons = TextEditingController();

class WaitingPayment extends GetView<OrderDetailController> {
  final localStorage = GetStorage();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    bool isDelivery = false;
    dynamic arguments = Get.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getOrder(arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                var currentUserId = localStorage.read('currentUserId');
                var orderId = Get.arguments;
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
                        localStorage.write('expense', charge);

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
                                      '   Order Status',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'SanFrancisco',
                                          color: Color(0xffF9813A)),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Container(
                                        height: height * 0.11,
                                        width: width * 0.9,
                                        decoration: BoxDecoration(
                                            color: Color(0xffF9813A),
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
                                      height: 16,
                                    ),
                                    Text(
                                      '   Order Detail',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'SanFrancisco',
                                          color: Color(0xffF9813A)),
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Pet Name',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'SanFrancisco.Light',
                                                          color: Colors
                                                              .grey.shade700)),
                                                  Text("Aero",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'SanFrancisco',
                                                          color: Colors
                                                              .grey.shade600)),
                                                ],
                                              ),
                                              Spacer(),
                                              bookingType == 'Vet'
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text('Medical service',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'SanFrancisco.Light',
                                                                color: Colors
                                                                    .grey
                                                                    .shade700)),
                                                        FutureBuilder<
                                                                DocumentSnapshot<
                                                                    Object?>>(
                                                            future: controller
                                                                .getMedicalDetail(
                                                                    data[
                                                                        'medicalId']),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .done) {
                                                                var medicalData = snapshot
                                                                        .data!
                                                                        .data()
                                                                    as Map<
                                                                        String,
                                                                        dynamic>;
                                                                return Text(
                                                                    medicalData[
                                                                        'name'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'SanFrancisco',
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600));
                                                              } else {
                                                                return Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                );
                                                              }
                                                            }),
                                                      ],
                                                    )
                                                  : Spacer(),
                                              bookingType == 'Vet'
                                                  ? Spacer()
                                                  : SizedBox(),
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
                                                  : Spacer(),
                                              bookingType == 'Vet'
                                                  ? Spacer()
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
                                                              0xffF9813A))),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () => {
                                        Get.toNamed(Routes.PAYMENT,
                                            arguments: orderId),
                                        localStorage.write(
                                            'orderPrice', fo.symbolOnLeft)
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        primary: Color(0xffF9813A),
                                        shape: StadiumBorder(),
                                      ),
                                      child: Container(
                                        height: height * 0.06,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text("Proceed to Payment",
                                                  style: TextStyle(
                                                    fontFamily: 'SanFrancisco',
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  )),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                                size: 18,
                                              )
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
