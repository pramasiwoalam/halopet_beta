import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_formatter/money_formatter.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    final localStorage = GetStorage();
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var orderId = Get.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Payment',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        backgroundColor: Color(0xffF9813A),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getOrder(orderId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                var currentUserId = localStorage.read('currentUserId');
                var orderId = Get.arguments;
                localStorage.write('petshopId', Get.arguments);
                double charge = data['charge'];
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
                              '   Order Summary',
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
                                height: height * 0.12,
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
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          Text(orderId,
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
                                          Text('Charge',
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                          Text(fo.symbolOnLeft,
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
                              '   Choose Payment Method',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Color(0xffF9813A)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomRadioButton(
                              elevation: 3,
                              buttonTextStyle: ButtonTextStyle(
                                  selectedColor: Colors.white,
                                  unSelectedColor: Color(0xffF9813A),
                                  textStyle: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                      color: Colors.white)),
                              unSelectedColor: Colors.white,
                              buttonLables: const [
                                "PawPay Coins",
                                "Transfer Manual",
                                "Virtual Account",
                              ],
                              buttonValues: const [
                                "ewallet",
                                "transfer",
                                "virtual",
                              ],
                              radioButtonValue: (value) {
                                controller.paymentType.value = value.toString();
                              },
                              defaultSelected: "ewallet",
                              unSelectedBorderColor: Colors.grey.shade100,
                              selectedBorderColor: Color(0xffF9813A),
                              spacing: 1,
                              horizontal: false,
                              enableButtonWrap: false,
                              height: height * 0.04,
                              enableShape: true,
                              width: width * 0.38,
                              absoluteZeroSpacing: false,
                              selectedColor: Color(0xffF9813A),
                              padding: 10,
                            ),
                            Obx(
                              () => controller.paymentType.value == 'ewallet'
                                  ? Container(
                                      margin: EdgeInsets.only(top: 15),
                                      height: height * 0.15,
                                      width: width * 0.9,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 0.8,
                                              color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        fo.symbolOnLeft,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .grey
                                                                    .shade800,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 15),
                                                      ),
                                                      Text(
                                                        'PawPay Coins',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .grey
                                                                    .shade800,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 12),
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
                                                onTap: () => {},
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
                                                          color: Colors
                                                              .grey.shade800,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : controller.paymentType.value == 'virtual'
                                      ? Center(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              top: height * 0.02,
                                            ),
                                            height: height * 0.25,
                                            width: width * 0.9,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
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
                                              padding: const EdgeInsets.all(24),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Virtual Account',
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
                                                      Text('Virtual Account',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500)),
                                                      Text('088266860291990',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500))
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Bank',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500)),
                                                      Text(
                                                          'Bank Central Asia (BCA)',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500))
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Nama Rekening',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500)),
                                                      Text(
                                                          'PT. Halopet Indonesia',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500))
                                                    ],
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: height * 0.02),
                                            height: height * 0.25,
                                            width: width * 0.9,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
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
                                              padding: const EdgeInsets.all(24),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Transfer Manual',
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
                                                      Text('Rekening',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500)),
                                                      Text('6860291990',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500))
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Bank',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500)),
                                                      Text(
                                                          'Bank Central Asia (BCA)',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500))
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Nama Rekening',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500)),
                                                      Text(
                                                          'PT. Halopet Indonesia',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500))
                                                    ],
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () => {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.INFO,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'Payment Confirmation',
                                    desc:
                                        'Are you sure you have did your payment?.',
                                    btnCancelOnPress: () => {},
                                    btnCancelColor: Colors.blue,
                                    btnOkColor: Color(0xffF9813A),
                                    btnOkText: 'Yes',
                                    buttonsTextStyle: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600),
                                    btnOkOnPress: () {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.SUCCES,
                                        animType: AnimType.BOTTOMSLIDE,
                                        title: 'Thank You.',
                                        desc:
                                            'Thank you for your payment. Your payment will be validated automatically',
                                        btnOkColor: Color(0xffF9813A),
                                        btnOkText: 'Ok',
                                        buttonsTextStyle: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w600),
                                        btnOkOnPress: () {
                                          controller.paymentAccepted(orderId);
                                        },
                                      ).show();
                                    },
                                  ).show()
                                },
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
                                      color: Color(0xffF9813A),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30))),
                                  child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 30, right: 25),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Done',
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17,
                                                  color: Colors.white)),
                                          const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: 22,
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30))),
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
      ),
    );
  }
}
