import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../delivery_list/controllers/delivery_list_controller.dart';
import '../controllers/grooming_order_controller.dart';

class VetOrderView extends GetView<GroomingOrderController> {
  final orderController = Get.put(GroomingOrderController());
  final typeController = TextEditingController();
  final deliveryController = Get.put(DeliveryListController());

  void setValue(DateTime dateTime) {
    var date = DateFormat('MMMM dd, yyyy').format(dateTime);
    orderController.date.value = date;
  }

  Map<String, dynamic> formData = {
    'symptoms': "Abdomen",
  };

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var petId = localStorage.read('petId');
    DateFormat format = new DateFormat("MMMM dd, yyyy");
    print(localStorage.read('deliveryCharge'));

    void getTime(TimeOfDay time) {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');
      controller.time.value = "Pick Up Time: ${hours}:${minutes}";
    }

    double bookingFee = 5000;
    double charge = 0;
    if (localStorage.read('deliveryCharge') == null) {
      charge = bookingFee;
    } else {
      charge = bookingFee + localStorage.read('deliveryCharge');
    }

    localStorage.write('totalCharge', charge);
    MoneyFormatter fmf = MoneyFormatter(
        amount: charge,
        settings: MoneyFormatterSettings(
          symbol: 'Rp.',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
        ));
    MoneyFormatterOutput fo = fmf.output;

    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getPets(petId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var dataMap = snapshot.data!.data() as Map<String, dynamic>;
                return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Container(
                      height: height * 0.55,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(0, 4))
                        ],
                        border:
                            Border.all(width: 1, color: Colors.grey.shade200),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(26.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.edit_note,
                                  size: 24,
                                  color: Colors.grey.shade800,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                VerticalDivider(
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Booking Confirmation',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 16),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Spacer(),
                            Text(
                              'Pet ID',
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 11),
                            ),
                            Text(
                              'P92S24ASD2',
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco.Regular',
                                  fontSize: 13),
                            ),
                            Spacer(),
                            Divider(
                              thickness: 1,
                            ),
                            Spacer(),
                            Text(
                              'Booking Date',
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 11),
                            ),
                            Text(
                              'June 29, 2022',
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco.Regular',
                                  fontSize: 13),
                            ),
                            Spacer(),
                            Divider(
                              thickness: 1,
                            ),
                            Spacer(),
                            Text(
                              'Petshop',
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 11),
                            ),
                            Text(
                              'Dita Gendut Petshop',
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco.Regular',
                                  fontSize: 13),
                            ),
                            Spacer(),
                            Divider(
                              thickness: 1,
                            ),
                            Spacer(),
                            Text(
                              'Session',
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 11),
                            ),
                            Text(
                              'Session 2, Drh. Gheara Juniszca, 09.00 AM - 11.00 AM',
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco.Regular',
                                  fontSize: 13),
                            ),
                            Spacer(),
                            Divider(
                              thickness: 1,
                            ),
                            Spacer(),
                            Text(
                              'Services',
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 11),
                            ),
                            Text(
                              'USG',
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco.Regular',
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
