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

class HotelOrderView extends GetView<GroomingOrderController> {
  final orderController = Get.put(GroomingOrderController());
  final typeController = TextEditingController();
  final deliveryController = Get.put(DeliveryListController());

  void setValue(DateTime dateTime) {
    var date = DateFormat('MMMM dd, yyyy').format(dateTime);
    orderController.date.value = date;
  }

  var roomName = localStorage.read('roomName');

  Map<String, dynamic> formData = {
    'symptoms': "Abdomen",
  };

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var petId = localStorage.read('petId');
    var roomId = localStorage.read('roomId');
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
            future: controller.getRoom(roomId),
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
                                SizedBox(
                                  height: 2,
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
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  roomName,
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
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.INFO,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'Booking Confirmation',
                                    desc:
                                        'Are you sure want to create this booking?.',
                                    btnCancelOnPress: () => {},
                                    btnOkText: 'Yes',
                                    buttonsTextStyle: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600),
                                    btnOkOnPress: () {
                                      deliveryController.deliveryFee == 0
                                          ? orderController.createHotelOrder(
                                              typeController.text,
                                              orderController.date.toString(),
                                              "Pet Hotel",
                                              localStorage.read('totalCharge'),
                                              controller.appointmentTime.value)
                                          : orderController
                                              .createHotelOrderWithDelivery(
                                                  petId,
                                                  orderController.date
                                                      .toString(),
                                                  localStorage
                                                      .read('serviceType'),
                                                  localStorage
                                                      .read('totalCharge'),
                                                  controller
                                                      .appointmentTime.value,
                                                  deliveryController.time
                                                      .toString(),
                                                  deliveryController
                                                      .deliveryFee);

                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.SUCCES,
                                        animType: AnimType.BOTTOMSLIDE,
                                        title: 'Booking Created.',
                                        desc: 'You can check your order here.',
                                        btnOkText: 'Check your order >',
                                        buttonsTextStyle: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w600),
                                        btnOkOnPress: () {
                                          Get.toNamed(Routes.ORDER);
                                        },
                                      ).show();
                                    },
                                  ).show()
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
