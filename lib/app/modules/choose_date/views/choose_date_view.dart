import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/grooming_order/controllers/grooming_order_controller.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../controllers/choose_date_controller.dart';

class ChooseDateView extends GetView<ChooseDateController> {
  final messageC = TextEditingController();
  final createOrderController = Get.put(GroomingOrderController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    var userId = GetStorage().read('currentUserId');
    var arguments = Get.arguments;
    var serviceName = localStorage.read('selectedServiceName');
    void setValue(DateTime dateTime) {
      var date = DateFormat('MMMM dd, yyyy').format(dateTime);
      createOrderController.date.value = date.toString();
      controller.date.value = date;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Choose Date',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 17),
        ),
        backgroundColor: Color(0xffF9813A),
        elevation: 0,
      ),
      body: Container(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                '      Choose Booking Date',
                style:
                    TextStyle(fontFamily: 'SanFrancisco.Regular', fontSize: 14),
              ),
              SizedBox(
                height: 12,
              ),
              Obx(
                () => FlatButton(
                  onPressed: () => {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2023))
                        .then((value) => {setValue(value!)})
                  },
                  child: Container(
                    height: height * 0.08,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, bottom: 12, left: 20, right: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            controller.date == "null"
                                ? const Text(
                                    'Choose booking date...',
                                    style: TextStyle(
                                        fontFamily: 'SanFrancisco.Light',
                                        fontSize: 13),
                                  )
                                : Text(
                                    controller.date.value.toString(),
                                    style: TextStyle(
                                      fontFamily: 'SanFrancisco.Regular',
                                      color: Colors.grey.shade700,
                                      fontSize: 14,
                                    ),
                                  ),
                            controller.date == "null"
                                ? Icon(
                                    Icons.calendar_month,
                                    size: 22,
                                    color: Colors.orange,
                                  )
                                : Icon(
                                    Icons.calendar_month,
                                    size: 22,
                                    color: Colors.orange,
                                  )
                          ]),
                    ),
                  ),
                ),
              ),
              // controller.date == "null" && serviceName == 'Grooming'
              //     ? SizedBox()
              //     : Obx(() => Container()),
              SizedBox(
                height: 25,
              ),
              FlatButton(
                  onPressed: () => {
                        if (createOrderController.date == "null".obs)
                          {
                            Get.dialog(AlertDialog(
                              title: Text(
                                'Date Not Found',
                                style: TextStyle(
                                    fontFamily: 'SanFrancisco', fontSize: 14),
                              ),
                              titlePadding:
                                  EdgeInsets.only(left: 26, right: 26, top: 30),
                              contentPadding: EdgeInsets.only(
                                  left: 26, right: 26, top: 16, bottom: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              content: Text(
                                  'You need to fill the date before you create the booking.',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 12)),
                              actionsPadding:
                                  EdgeInsets.only(right: 12, top: 6, bottom: 2),
                              actions: [
                                TextButton(
                                    onPressed: () => {Get.back()},
                                    child: Text(
                                      'Agreed.',
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco',
                                          fontSize: 13,
                                          color: Colors.orange),
                                    )),
                              ],
                            ))
                          }
                        else
                          {
                            if (arguments == 'Vet')
                              {
                                Get.toNamed(Routes.CHOOSE_SESSION,
                                    arguments: arguments)
                              }
                            else if (arguments == 'Hotel')
                              {Get.toNamed(Routes.CHOOSE_ROOM)}
                            else
                              {Get.toNamed(Routes.PACKAGE_LIST)}
                          }
                      },
                  child: Container(
                    height: height * 0.075,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(width: 1, color: Colors.grey.shade100),
                      color: Color(0xffF9813A),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Next',
                            style: TextStyle(
                                fontFamily: 'SanFrancisco',
                                fontSize: 13,
                                color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
