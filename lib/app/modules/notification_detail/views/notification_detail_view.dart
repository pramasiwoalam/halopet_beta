import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/notification_detail_controller.dart';

final reasons = TextEditingController();

class NotificationDetailView extends GetView<NotificationDetailController> {
  final localStorage = GetStorage();
  final messageC = TextEditingController();

  RxBool isDeclined = false.obs;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Notification Detail',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
        ),
        body: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getNotification(Get.arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                return Container(
                  height: height * 0.6,
                  width: width,
                  child: Center(
                    child: Container(
                      height: height * 0.35,
                      width: width * 0.85,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(width: 1, color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 2))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Spacer(),
                            Icon(
                              Icons.verified,
                              color: Colors.green,
                              size: 100,
                            ),
                            Spacer(),
                            Text(
                              'Booking ID #TR82362828 has been approved.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                            Spacer(),
                            FlatButton(
                                onPressed: () => {},
                                child: Container(
                                  height: height * 0.05,
                                  width: width * 0.35,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF9813A),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Order Detail',
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  )),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
