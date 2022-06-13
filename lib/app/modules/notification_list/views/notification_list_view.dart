import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/information/views/information_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/notification_list_controller.dart';

class NotificationListView extends GetView<NotificationListController> {
  final localStorage = GetStorage();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var userId = localStorage.read('currentUserId');

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Notification Center',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 17),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot<Object?>>(
              stream: controller.streamNotification(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var data = snapshot.data!.docs;
                  return ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var dataMap =
                            data[index].data() as Map<String, dynamic>;
                        return Container(
                          height: height * 0.15,
                          width: width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade300)),
                          child: FlatButton(
                            onPressed: () => {
                              Get.toNamed(Routes.NOTIFICATION_DETAIL,
                                  arguments: data[index].id),
                              controller.setIsOpened(data[index].id)
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: width * 0.07,
                                        height: height * 0.1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.info,
                                              color: Color.fromARGB(
                                                  255, 146, 194, 233),
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.78,
                                        height: height * 0.1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Info',
                                                    style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 12)),
                                                Text(
                                                    dataMap['dateCreated']
                                                        .toString(),
                                                    style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 12))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            dataMap['isOpened'] == false
                                                ? Text(dataMap['title'],
                                                    style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14))
                                                : Text(dataMap['title'],
                                                    style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 14)),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            dataMap['isOpened'] == false
                                                ? Text(dataMap['message'],
                                                    style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12))
                                                : Text(dataMap['message'],
                                                    style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 12))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}
