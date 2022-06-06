import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../grooming_order/controllers/grooming_order_controller.dart';
import '../controllers/delivery_list_controller.dart';

class DeliveryListView extends GetView<DeliveryListController> {
  final orderController = Get.put(DeliveryListController());
  final groomingController = Get.put(GroomingOrderController());
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var userId = localStorage.read('currentUserId');
    var finalCharge = 0;
    TimeOfDay time;

    void getTime(TimeOfDay time) {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');
      controller.time.value = "${hours}:${minutes}";
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Delivery Form',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 19),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
          centerTitle: true,
        ),
        body: FutureBuilder<DocumentSnapshot<Object?>>(
            future: orderController.getUser(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                return Container(
                  height: height,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          width: width * 0.8,
                          height: height * 0.07,
                          child: ToggleSwitch(
                            minWidth: width * 0.395,
                            cornerRadius: 20.0,
                            activeBgColors: [
                              [Color(0xffF9813A)],
                              [Color(0xffF9813A)]
                            ],
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey.shade300,
                            inactiveFgColor: Colors.white,
                            initialLabelIndex: 0,
                            totalSwitches: 2,
                            labels: ['Pick Up Only', 'Pick Up & Delivery'],
                            radiusStyle: true,
                            onToggle: (index) {
                              orderController.status.value = index.toString();
                              print(index);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: size.height * 0.065,
                          width: width,
                          child: TextField(
                            readOnly: true,
                            // controller: emailController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(16),
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                hintText: data['address'],
                                labelText: 'Address',
                                hintStyle: GoogleFonts.roboto(
                                    color: Colors.grey.shade600, fontSize: 14),
                                border: InputBorder.none,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              height: size.height * 0.065,
                              width: width * 0.43,
                              child: TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(16),
                                  isDense: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  hintText: data['city'],
                                  labelText: 'City',
                                  hintStyle: GoogleFonts.roboto(
                                      color: Colors.grey.shade600,
                                      fontSize: 14),
                                  border: InputBorder.none,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: size.height * 0.065,
                              width: width * 0.43,
                              child: TextField(
                                readOnly: true,
                                // controller: emailController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(16),
                                  isDense: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  hintText: data['postalCode'],
                                  labelText: 'Postal Code',
                                  hintStyle: GoogleFonts.roboto(
                                      color: Colors.grey.shade600,
                                      fontSize: 14),
                                  border: InputBorder.none,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: size.height * 0.065,
                          width: width,
                          child: TextField(
                            readOnly: true,
                            // controller: emailController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(16),
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                hintText: data['phone'],
                                labelText: 'Phone',
                                hintStyle: GoogleFonts.roboto(
                                    color: Colors.grey.shade600, fontSize: 14),
                                border: InputBorder.none,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Obx(
                          () => Container(
                            height: height * 0.07,
                            width: width,
                            child: FlatButton(
                              color: orderController.time == 'null'
                                  ? Colors.white
                                  : Color(0xffF9813A),
                              onPressed: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) => {getTime(value!)});
                              },
                              child: orderController.time == "null"
                                  ? Text(
                                      "Set Pick Up Time *",
                                      style: GoogleFonts.roboto(
                                          color: Colors.grey.shade700,
                                          fontSize: 15),
                                    )
                                  : Text(
                                      '${controller.time}',
                                      style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: orderController.time == 'null'
                                          ? Colors.grey.shade400
                                          : Colors.grey.shade100,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Obx(() => orderController.status == '0'
                            ? Column(
                                children: [
                                  FutureBuilder<DocumentSnapshot<Object?>>(
                                      future: controller.getPackage(
                                          localStorage.read('packageId')),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          var packageData = snapshot.data!
                                              .data() as Map<String, dynamic>;

                                          double pickUpFee = 20000;

                                          double charge = pickUpFee;
                                          controller.deliveryFee = charge;

                                          localStorage.write(
                                              'deliveryCharge', charge);
                                          MoneyFormatter fmf = MoneyFormatter(
                                              amount: charge,
                                              settings: MoneyFormatterSettings(
                                                symbol: 'Rp.',
                                                thousandSeparator: '.',
                                                decimalSeparator: ',',
                                                symbolAndNumberSeparator: ' ',
                                              ));
                                          MoneyFormatterOutput fo = fmf.output;
                                          return Container(
                                            height: height * 0.12,
                                            width: width * 0.9,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Colors.grey.shade300,
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 2))
                                                ]),
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Pick Up Charge',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500)),
                                                      Text("Rp. $pickUpFee",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500)),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Total Delivery Charge',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500)),
                                                      Text(fo.symbolOnLeft,
                                                          style: GoogleFonts.roboto(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xffF9813A))),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  FlatButton(
                                      padding: EdgeInsets.all(15),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      color: Color(0xffF9813A),
                                      height: height * 0.08,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Confirm Delivery",
                                                style: GoogleFonts.inter(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios,
                                                color: Colors.white),
                                          ],
                                        ),
                                      ),
                                      onPressed: () => {
                                            groomingController.status = 0,
                                            Get.toNamed(Routes.CREATE_ORDER,
                                                arguments: 'Grooming'),
                                          }),
                                ],
                              )
                            : Column(
                                children: [
                                  FutureBuilder<DocumentSnapshot<Object?>>(
                                      future: controller.getPackage(
                                          localStorage.read('packageId')),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          var packageData = snapshot.data!
                                              .data() as Map<String, dynamic>;

                                          double pickUpFee = 20000;
                                          double deliveryFee = 22000;
                                          double charge =
                                              pickUpFee + deliveryFee;
                                          controller.deliveryFee = charge;
                                          localStorage.write(
                                              'deliveryCharge', charge);
                                          MoneyFormatter fmf = MoneyFormatter(
                                              amount: charge,
                                              settings: MoneyFormatterSettings(
                                                symbol: 'Rp.',
                                                thousandSeparator: '.',
                                                decimalSeparator: ',',
                                                symbolAndNumberSeparator: ' ',
                                              ));
                                          MoneyFormatterOutput fo = fmf.output;
                                          return Container(
                                            height: height * 0.2,
                                            width: width * 0.9,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Colors.grey.shade300,
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 2))
                                                ]),
                                            child: Padding(
                                              padding: const EdgeInsets.all(26),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Pick Up Charge',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500)),
                                                      Text("Rp. $pickUpFee",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500)),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Delivery Charge',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500)),
                                                      Text("Rp. $deliveryFee",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500)),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Total Delivery Charge',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500)),
                                                      Text(fo.symbolOnLeft,
                                                          style: GoogleFonts.roboto(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: 16,
                                                              color: Color(
                                                                  0xffF9813A))),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  FlatButton(
                                      padding: EdgeInsets.all(15),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      color: Color(0xffF9813A),
                                      height: height * 0.08,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Confirm Delivery",
                                                style: GoogleFonts.inter(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios,
                                                color: Colors.white),
                                          ],
                                        ),
                                      ),
                                      onPressed: () => {
                                            groomingController.status = 0,
                                            Get.toNamed(Routes.CREATE_ORDER,
                                                arguments: 'Grooming'),
                                          }),
                                ],
                              )),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
