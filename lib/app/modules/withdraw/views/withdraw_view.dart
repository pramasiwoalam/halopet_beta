import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import 'package:money_formatter/money_formatter.dart';

import '../controllers/withdraw_controller.dart';

final balanceController = TextEditingController();

class WithdrawView extends GetView<WithdrawController> {
  @override
  Widget build(BuildContext context) {
    final localStorage = GetStorage();
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    Map<String, dynamic> userData = localStorage.read('userData');
    var userId = localStorage.read('currentUserId');
    double balance = localStorage.read('balance');
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
          'Withdraw',
          style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 15),
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
                          labelText: 'Input Withdraw Balance',
                          hintStyle: GoogleFonts.roboto(
                              color: Colors.grey.shade600, fontSize: 13),
                          border: InputBorder.none,
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('  Withdrawn to',
                            style: TextStyle(
                                fontFamily: 'SanFrancisco.Light',
                                fontSize: 13)),
                        Text('')
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: height * 0.02,
                      ),
                      height: height * 0.25,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
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
                            Text('Bank Account',
                                style: TextStyle(
                                    fontFamily: 'SanFrancisco', fontSize: 14)),
                            const Divider(
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Account Number',
                                    style: TextStyle(
                                        fontFamily: 'SanFrancisco.Light',
                                        fontSize: 12)),
                                Text(userData['accountNumber'],
                                    style: TextStyle(
                                        fontFamily: 'SanFrancisco',
                                        fontSize: 12)),
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Bank',
                                    style: TextStyle(
                                        fontFamily: 'SanFrancisco.Light',
                                        fontSize: 12)),
                                Text(userData['bankAccount'],
                                    style: TextStyle(
                                        fontFamily: 'SanFrancisco',
                                        fontSize: 12)),
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Account Name',
                                    style: TextStyle(
                                        fontFamily: 'SanFrancisco.Light',
                                        fontSize: 12)),
                                Text(userData['bankAccountName'],
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
                          content: const Text(
                              'Are you sure want to withdrawn this amount?',
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 12)),
                          actionsPadding:
                              EdgeInsets.only(right: 15, top: 6, bottom: 2),
                          actions: [
                            TextButton(
                                onPressed: () => {
                                      Get.back(),
                                    },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 13,
                                      color: Colors.orange),
                                )),
                            TextButton(
                                onPressed: () => {
                                      if (balance <
                                          int.parse(balanceController.text))
                                        {
                                          Get.dialog(AlertDialog(
                                            title: Text(
                                              'Insufficient Balance',
                                              style: TextStyle(
                                                  fontFamily: 'SanFrancisco',
                                                  fontSize: 14),
                                            ),
                                            titlePadding: EdgeInsets.only(
                                                left: 26, right: 26, top: 30),
                                            contentPadding: EdgeInsets.only(
                                                left: 26,
                                                right: 26,
                                                top: 16,
                                                bottom: 12),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            content: Text(
                                                'Your balance is insufficient for withdrawn your request. Please input your withdrawn request correctly.',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'SanFrancisco.Light',
                                                    fontSize: 12)),
                                            actionsPadding: EdgeInsets.only(
                                                right: 12, top: 6, bottom: 2),
                                            actions: [
                                              TextButton(
                                                  onPressed: () => {Get.back()},
                                                  child: Text(
                                                    'Agreed.',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'SanFrancisco',
                                                        fontSize: 13,
                                                        color: Colors.orange),
                                                  )),
                                            ],
                                          ))
                                        }
                                      else
                                        {
                                          controller.withdrawn(
                                            userId,
                                            int.parse(balanceController.text),
                                          ),
                                          Get.dialog(AlertDialog(
                                            title: Text(
                                              'Withdrawn Success',
                                              style: TextStyle(
                                                  fontFamily: 'SanFrancisco',
                                                  fontSize: 14),
                                            ),
                                            titlePadding: EdgeInsets.only(
                                                left: 26, right: 26, top: 30),
                                            contentPadding: EdgeInsets.only(
                                                left: 26,
                                                right: 26,
                                                top: 16,
                                                bottom: 12),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            content: Text(
                                                'Your withdrawn request is successful. Thank you for using PawPay Coins.',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'SanFrancisco.Light',
                                                    fontSize: 12)),
                                            actionsPadding: EdgeInsets.only(
                                                right: 12, top: 6, bottom: 2),
                                            actions: [
                                              TextButton(
                                                  onPressed: () => {
                                                        Get.toNamed(
                                                            Routes.HOMEPAGE),
                                                      },
                                                  child: Text(
                                                    'Ok',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'SanFrancisco',
                                                        fontSize: 13,
                                                        color: Colors.orange),
                                                  )),
                                            ],
                                          ))
                                        }
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
                                Text('Withdraw',
                                    style: TextStyle(
                                        fontFamily: 'SanFrancisco',
                                        fontSize: 15,
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
