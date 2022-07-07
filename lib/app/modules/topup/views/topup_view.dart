import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import 'package:money_formatter/money_formatter.dart';

import '../controllers/topup_controller.dart';

final balanceController = TextEditingController();

class TopUpView extends GetView<TopUpController> {
  @override
  Widget build(BuildContext context) {
    final localStorage = GetStorage();
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var userId = localStorage.read('currentUserId');
    int balance = localStorage.read('balance');
    MoneyFormatter fmf = MoneyFormatter(
        amount: balance.roundToDouble(),
        settings: MoneyFormatterSettings(
          symbol: 'Rp.',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
        ));
    MoneyFormatterOutput fo = fmf.output;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Top Up',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        backgroundColor: Color(0xffF9813A),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Column(
              children: [
                Container(
                  height: height * 0.14,
                  width: width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(width: 0.8, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(1, 2))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Your current PawPay coins: ',
                              style: GoogleFonts.roboto(
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13),
                            ),
                            SizedBox(
                              height: 6,
                            ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      fo.symbolOnLeft,
                                      style: GoogleFonts.roboto(
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      'PawPay Coins',
                                      style: GoogleFonts.roboto(
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.065,
                    width: width * 0.85,
                    child: TextField(
                      controller: balanceController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade400, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade400, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          hintText: 'Rp. 100.000',
                          labelText: 'Input Top Up Balance',
                          hintStyle: GoogleFonts.roboto(
                              color: Colors.grey.shade600, fontSize: 14),
                          border: InputBorder.none,
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('  Choose Payment',
                            style: TextStyle(
                                fontFamily: 'SanFrancisco.Light',
                                fontSize: 13)),
                        Text('')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 16, top: 6),
                    child: CustomRadioButton(
                      elevation: 2,
                      buttonTextStyle: ButtonTextStyle(
                          selectedColor: Colors.white,
                          unSelectedColor: Color(0xffF9813A),
                          textStyle: TextStyle(
                              fontFamily: 'SanFrancisco', fontSize: 12)),
                      unSelectedColor: Colors.white,
                      buttonLables: const [
                        "Transfer Manual",
                        "Virtual Account",
                      ],
                      buttonValues: const [
                        "transfer",
                        "virtual",
                      ],
                      radioButtonValue: (value) {
                        controller.paymentType.value = value.toString();
                        print(controller.paymentType);
                      },
                      defaultSelected: "transfer",
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Obx(
                      () => controller.paymentType.value == 'virtual'
                          ? Center(
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: height * 0.02,
                                ),
                                height: height * 0.25,
                                width: width * 0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
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
                                      Text('Virtual Account',
                                          style: TextStyle(
                                              fontFamily: 'SanFrancisco',
                                              fontSize: 14)),
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
                                          Text('Virtual Account',
                                              style: TextStyle(
                                                  fontFamily:
                                                      'SanFrancisco.Light',
                                                  fontSize: 12)),
                                          Text('088266860291990',
                                              style: TextStyle(
                                                  fontFamily: 'SanFrancisco',
                                                  fontSize: 12)),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Bank',
                                              style: TextStyle(
                                                  fontFamily:
                                                      'SanFrancisco.Light',
                                                  fontSize: 12)),
                                          Text('Bank Central Asia (BCA)',
                                              style: TextStyle(
                                                  fontFamily: 'SanFrancisco',
                                                  fontSize: 12)),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Nama Rekening',
                                              style: TextStyle(
                                                  fontFamily:
                                                      'SanFrancisco.Light',
                                                  fontSize: 12)),
                                          Text('PT. Halopet Indonesia',
                                              style: TextStyle(
                                                  fontFamily: 'SanFrancisco',
                                                  fontSize: 12)),
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
                                margin: EdgeInsets.only(top: height * 0.02),
                                height: height * 0.25,
                                width: width * 0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
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
                                      Text('Transfer Manual',
                                          style: TextStyle(
                                              fontFamily: 'SanFrancisco',
                                              fontSize: 14)),
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
                                          Text('Rekening',
                                              style: TextStyle(
                                                  fontFamily:
                                                      'SanFrancisco.Light',
                                                  fontSize: 12)),
                                          Text('6860291990',
                                              style: TextStyle(
                                                  fontFamily: 'SanFrancisco',
                                                  fontSize: 12)),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Bank',
                                              style: TextStyle(
                                                  fontFamily:
                                                      'SanFrancisco.Light',
                                                  fontSize: 12)),
                                          Text('Bank Central Asia (BCA)',
                                              style: TextStyle(
                                                  fontFamily: 'SanFrancisco',
                                                  fontSize: 12)),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Nama Rekening',
                                              style: TextStyle(
                                                  fontFamily:
                                                      'SanFrancisco.Light',
                                                  fontSize: 12)),
                                          Text('PT. Halopet Indonesia',
                                              style: TextStyle(
                                                  fontFamily: 'SanFrancisco',
                                                  fontSize: 12)),
                                        ],
                                      ),
                                      Spacer(),
                                    ],
                                  ),
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
                            'Confirmation',
                            style: TextStyle(
                                fontFamily: 'SanFrancisco', fontSize: 14),
                          ),
                          titlePadding:
                              EdgeInsets.only(left: 26, right: 26, top: 30),
                          contentPadding: const EdgeInsets.only(
                              left: 26, right: 26, top: 16, bottom: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          content: const Text('Are you sure want to top up?',
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 12)),
                          actionsPadding:
                              EdgeInsets.only(right: 15, top: 6, bottom: 2),
                          actions: [
                            TextButton(
                                onPressed: () => {Get.back()},
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 13,
                                      color: Colors.orange),
                                )),
                            TextButton(
                                onPressed: () => {
                                      Get.back(),
                                      Get.dialog(AlertDialog(
                                        title: const Text(
                                          'Top Up Success',
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
                                            'Your top up request is succesful. Thank You for using PawPay',
                                            style: TextStyle(
                                                fontFamily:
                                                    'SanFrancisco.Light',
                                                fontSize: 12)),
                                        actionsPadding: EdgeInsets.only(
                                            right: 15, top: 6, bottom: 2),
                                        actions: [
                                          TextButton(
                                              onPressed: () => {
                                                    Get.back(),
                                                    controller.topUp(
                                                        userId, balance),
                                                    Get.toNamed(Routes.HOMEPAGE)
                                                  },
                                              child: Text(
                                                'Ok',
                                                style: TextStyle(
                                                    fontFamily: 'SanFrancisco',
                                                    fontSize: 13,
                                                    color: Colors.orange),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                            padding: EdgeInsets.only(left: 30, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Top Up',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
