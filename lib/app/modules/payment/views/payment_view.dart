import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
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
    var expense = localStorage.read('orderPrice');
    var userId = localStorage.read('currentUserId');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Payment',
          style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 15),
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
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco',
                                  fontSize: 14,
                                  color: Colors.grey.shade700),
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
                                          Text(
                                            'Order ID',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    'SanFrancisco.Light',
                                                fontSize: 13),
                                          ),
                                          Text(
                                            orderId,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'SanFrancisco',
                                                fontSize: 13),
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Charge',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    'SanFrancisco.Light',
                                                fontSize: 13),
                                          ),
                                          Text(
                                            expense.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'SanFrancisco',
                                                fontSize: 13),
                                          )
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
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco',
                                  fontSize: 14,
                                  color: Colors.grey.shade700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomRadioButton(
                              elevation: 1,
                              buttonTextStyle: ButtonTextStyle(
                                  selectedColor: Colors.white,
                                  unSelectedColor: Color(0xffF9813A),
                                  textStyle: TextStyle(
                                      fontFamily: 'SanFrancisco',
                                      fontSize: 11,
                                      color: Colors.grey.shade700)),
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
                              height: height * 0.03,
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
                                      child: FutureBuilder<
                                              DocumentSnapshot<Object?>>(
                                          future: controller.getUser(userId),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              var data = snapshot.data!.data()
                                                  as Map<String, dynamic>;
                                              double userBalance =
                                                  data['balance'];
                                              MoneyFormatter mf =
                                                  MoneyFormatter(
                                                      amount: userBalance,
                                                      settings:
                                                          MoneyFormatterSettings(
                                                        symbol: 'Rp.',
                                                        thousandSeparator: '.',
                                                        decimalSeparator: ',',
                                                        symbolAndNumberSeparator:
                                                            ' ',
                                                      ));
                                              MoneyFormatterOutput fmo =
                                                  mf.output;
                                              return Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .monetization_on,
                                                            color:
                                                                Colors.orange,
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
                                                                fmo.symbolOnLeft
                                                                    .toString(),
                                                                style: GoogleFonts.roboto(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade800,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(
                                                                'PawPay Coins',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'SanFrancisco.Light',
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade700),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      VerticalDivider(
                                                        color: Colors
                                                            .grey.shade300,
                                                        thickness: 1,
                                                      ),
                                                      InkWell(
                                                        onTap: () => {},
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.orange,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              'Top up PawPay',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'SanFrancisco',
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return CircularProgressIndicator();
                                            }
                                          }),
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
                                                  Text(
                                                    'Virtual Account',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'SanFrancisco',
                                                        fontSize: 13,
                                                        color: Colors
                                                            .grey.shade700),
                                                  ),
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
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 12,
                                                              color: Colors.grey
                                                                  .shade500)),
                                                      Text(
                                                        '088266860291990',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'SanFrancisco',
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey.shade700),
                                                      )
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Bank',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 12,
                                                              color: Colors.grey
                                                                  .shade500)),
                                                      Text(
                                                          'Bank Central Asia (BCA)',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco',
                                                              fontSize: 12,
                                                              color: Colors.grey
                                                                  .shade700)),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Nama Rekening',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 12,
                                                              color: Colors.grey
                                                                  .shade500)),
                                                      Text(
                                                          'PT. Halopet Indonesia',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco',
                                                              fontSize: 12,
                                                              color: Colors.grey
                                                                  .shade700)),
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
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'SanFrancisco',
                                                          fontSize: 13,
                                                          color: Colors
                                                              .grey.shade700)),
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
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 12,
                                                              color: Colors.grey
                                                                  .shade500)),
                                                      Text('6860291990',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco',
                                                              fontSize: 12,
                                                              color: Colors.grey
                                                                  .shade700)),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Bank',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 12,
                                                              color: Colors.grey
                                                                  .shade500)),
                                                      Text(
                                                          'Bank Central Asia (BCA)',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco',
                                                              fontSize: 12,
                                                              color: Colors.grey
                                                                  .shade700)),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Nama Rekening',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 12,
                                                              color: Colors.grey
                                                                  .shade500)),
                                                      Text(
                                                          'PT. Halopet Indonesia',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco',
                                                              fontSize: 12,
                                                              color: Colors.grey
                                                                  .shade700)),
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
                                  Get.dialog(AlertDialog(
                                    title: const Text(
                                      'Payment Confirmation',
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco',
                                          fontSize: 14),
                                    ),
                                    titlePadding: EdgeInsets.only(
                                        left: 26, right: 26, top: 30),
                                    contentPadding: const EdgeInsets.only(
                                        left: 26,
                                        right: 26,
                                        top: 16,
                                        bottom: 12),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    content: const Text(
                                        'Are you sure you have do your payment?',
                                        style: TextStyle(
                                            fontFamily: 'SanFrancisco.Light',
                                            fontSize: 12)),
                                    actionsPadding: EdgeInsets.only(
                                        right: 15, top: 6, bottom: 2),
                                    actions: [
                                      TextButton(
                                          onPressed: () => {Get.back()},
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontFamily:
                                                    'SanFrancisco.Light',
                                                fontSize: 13,
                                                color: Colors.orange),
                                          )),
                                      TextButton(
                                          onPressed: () => {
                                                Get.back(),
                                                Get.dialog(AlertDialog(
                                                  title: Text(
                                                    'Booking Created',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'SanFrancisco',
                                                        fontSize: 14),
                                                  ),
                                                  titlePadding: EdgeInsets.only(
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
                                                          BorderRadius.circular(
                                                              15)),
                                                  content: Text(
                                                      'Thank you for your payment. Your payment will be validated automatically',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'SanFrancisco.Light',
                                                          fontSize: 12)),
                                                  actionsPadding:
                                                      EdgeInsets.only(
                                                          right: 12,
                                                          top: 6,
                                                          bottom: 2),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () => {
                                                              controller
                                                                  .paymentAccepted(
                                                                      orderId),
                                                              Get.toNamed(Routes
                                                                  .HOMEPAGE)
                                                            },
                                                        child: Text(
                                                          'Ok',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco',
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .orange),
                                                        )),
                                                  ],
                                                ))
                                              },
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                                fontFamily: 'SanFrancisco',
                                                fontSize: 13,
                                                color: Colors.orange),
                                          )),
                                    ],
                                  ))
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
                                              style: TextStyle(
                                                  fontFamily: 'SanFrancisco',
                                                  fontSize: 14,
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
                                              style: TextStyle(
                                                  fontFamily: 'SanFrancisco',
                                                  fontSize: 14,
                                                  color: Color(0xffF9813A))),
                                          const Icon(
                                            Icons.cancel_schedule_send,
                                            color: Color(0xffF9813A),
                                            size: 18,
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
