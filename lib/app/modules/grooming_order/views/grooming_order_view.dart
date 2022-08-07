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

class GroomingOrderView extends GetView<GroomingOrderController> {
  final orderController = Get.put(GroomingOrderController());
  final typeController = TextEditingController();
  final deliveryController = Get.put(DeliveryListController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var petId = localStorage.read('petId');
    var packageId = localStorage.read('packageId');
    print(packageId);
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
            future: controller.getPackage(packageId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var dataMap = snapshot.data!.data() as Map<String, dynamic>;
                return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.6,
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
                            border: Border.all(
                                width: 1, color: Colors.grey.shade200),
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
                                SizedBox(
                                  height: 2,
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
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  controller.date.toString(),
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
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Petshop A',
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
                                  'Package',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 11),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  dataMap['name'],
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
                                  'Package Detail',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 11),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  dataMap['desc'],
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
                                  'Booking Fee',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 11),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'Rp. ${dataMap['price']}',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Regular',
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        FlatButton(
                            onPressed: () => {
                                  Get.dialog(AlertDialog(
                                    title: Text(
                                      'Booking Confirmation',
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
                                        'Are the booking data is correct? Confirm if you want to create this booking.',
                                        style: TextStyle(
                                            fontFamily: 'SanFrancisco.Light',
                                            fontSize: 12)),
                                    actionsPadding: EdgeInsets.only(
                                        right: 12, top: 6, bottom: 2),
                                    actions: [
                                      TextButton(
                                          onPressed: () => {Get.back()},
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontFamily:
                                                    'SanFrancisco.Light',
                                                fontSize: 13,
                                                color: Colors.orange),
                                          )),
                                      TextButton(
                                          onPressed: () => {
                                                deliveryController
                                                            .deliveryFee ==
                                                        0
                                                    ? orderController
                                                        .createGroomingOrder(
                                                            typeController.text,
                                                            orderController.date
                                                                .toString(),
                                                            "Grooming Service",
                                                            localStorage
                                                                .read(
                                                                    'totalCharge'),
                                                            controller.appointmentTime
                                                                .value)
                                                    : orderController
                                                        .createGroomingOrderWithDelivery(
                                                            petId,
                                                            orderController.date
                                                                .toString(),
                                                            'Grooming Service',
                                                            localStorage
                                                                .read(
                                                                    'totalCharge'),
                                                            controller
                                                                .appointmentTime
                                                                .value,
                                                            deliveryController
                                                                .time
                                                                .toString(),
                                                            deliveryController
                                                                .deliveryFee),
                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.SUCCES,
                                                  animType:
                                                      AnimType.BOTTOMSLIDE,
                                                  title: 'Booking Created.',
                                                  desc:
                                                      'You can check your order here.',
                                                  btnOkText:
                                                      'Check your order >',
                                                  buttonsTextStyle: TextStyle(
                                                    fontFamily: 'SanFrancisco',
                                                    fontSize: 14,
                                                  ),
                                                  btnOkOnPress: () {
                                                    Get.toNamed(Routes.ORDER);
                                                  },
                                                ).show()
                                              },
                                          child: Text(
                                            'Confirm',
                                            style: TextStyle(
                                                fontFamily: 'SanFrancisco',
                                                fontSize: 13,
                                                color: Colors.orange),
                                          )),
                                    ],
                                  ))
                                },
                            child: Container(
                                height: height * 0.07,
                                width: width,
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
                                        BorderRadius.all(Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text("Create Booking",
                                          style: TextStyle(
                                            fontFamily: 'SanFrancisco',
                                            fontSize: 15,
                                            color: Colors.white,
                                          )),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                )))
                      ],
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
