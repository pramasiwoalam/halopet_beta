import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/admin_petshop_approval_controller.dart';

class AdminPetshopApprovalView extends GetView<AdminPetshopApprovalController> {
  final localStorage = GetStorage();
  dynamic arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Petshop Approval',
          style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 15),
        ),
        backgroundColor: Color(0xFFF33ca7f),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getPetshop(arguments),
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
                                      Icons.house,
                                      size: 22,
                                      color: Color(0xFFF33ca7f),
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
                                      'Petshop Detail',
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
                                  'Name',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  dataMap['petshopName'],
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco', fontSize: 13),
                                ),
                                Spacer(),
                                Divider(
                                  thickness: 1,
                                ),
                                Spacer(),
                                Text(
                                  'Address',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  dataMap['petshopAddress'],
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco', fontSize: 13),
                                ),
                                Spacer(),
                                Divider(
                                  thickness: 1,
                                ),
                                Spacer(),
                                Text(
                                  'District',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  dataMap['district'],
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco', fontSize: 13),
                                ),
                                Spacer(),
                                Divider(
                                  thickness: 1,
                                ),
                                Spacer(),
                                Text(
                                  'City',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  dataMap['city'],
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco', fontSize: 13),
                                ),
                                Spacer(),
                                Divider(
                                  thickness: 1,
                                ),
                                Spacer(),
                                Text(
                                  'Petshop Created',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'June 6, 2022',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco', fontSize: 13),
                                ),
                                Spacer(),
                                Divider(
                                  thickness: 1,
                                ),
                                Spacer(),
                                Text(
                                  'Service Available',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                dataMap['vetService'] == true
                                    ? Text(
                                        'Vet Available',
                                        style: TextStyle(
                                          fontFamily: 'SanFrancisco',
                                          fontSize: 13,
                                        ),
                                      )
                                    : SizedBox(),
                                dataMap['groomingService'] == true
                                    ? Text(
                                        'Grooming Service',
                                        style: TextStyle(
                                          fontFamily: 'SanFrancisco',
                                          fontSize: 13,
                                        ),
                                      )
                                    : SizedBox(),
                                dataMap['petHotelService'] == true
                                    ? Text(
                                        'Pet Hotel Services',
                                        style: TextStyle(
                                          fontFamily: 'SanFrancisco',
                                          fontSize: 13,
                                        ),
                                      )
                                    : SizedBox(),
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
                                        'Approval Confirmation',
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
                                          'Are you want to approve this petshop?',
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
                                            onPressed: () => {},
                                            child: Text(
                                              'Confirm',
                                              style: TextStyle(
                                                  fontFamily: 'SanFrancisco',
                                                  fontSize: 13,
                                                  color: Colors.orange),
                                            )),
                                      ]))
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
                                    color: Color(0xFFF33ca7f),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text("Approve",
                                          style: TextStyle(
                                            fontFamily: 'SanFrancisco',
                                            fontSize: 14,
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
