import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/session_list_controller.dart';

class SessionListView extends GetView<SessionListController> {
  final messageC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    var userId = GetStorage().read('currentUserId');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Session List',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        backgroundColor: Color(0xffF9813A),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Container(
        height: height,
        width: width,
        child: StreamBuilder<QuerySnapshot<Object?>>(
          stream: controller.getSession(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var data = snapshot.data!.docs;
              if (data.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height / 4,
                        ),
                        Text(
                            "You don't have any session registered. Please register your session first.",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w300, fontSize: 15)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: width * 0.22,
                          height: width * 0.22,
                          child: FlatButton(
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Colors.grey.shade200,
                            height: height * 0.04,
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Register',
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco',
                                          fontSize: 14,
                                          color: Colors.grey.shade800))
                                ],
                              ),
                            ),
                            onPressed: () => Get.toNamed(Routes.SERVICE_FORM,
                                arguments: 'Vet'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                if (data.isEmpty) {
                  return Container(
                    child: Column(
                      children: [
                        Text('You dont have any pet. Register >'),
                        ElevatedButton(
                            onPressed: () => Get.toNamed(Routes.PET_FORM),
                            child: Text('Register'))
                      ],
                    ),
                  );
                } else {
                  return StreamBuilder<QuerySnapshot<Object?>>(
                      stream: controller.getSession(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          var data = snapshot.data!.docs;
                          return Container(
                              child: Column(
                            children: [
                              ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    var dataMap = data[index].data()
                                        as Map<String, dynamic>;

                                    return InkWell(
                                        onTap: () => {
                                              Get.toNamed(Routes.SESSION_DETAIL,
                                                  arguments: data[index].id)
                                            },
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 24.0, right: 24, top: 24),
                                            child: controller.vetFlag == false
                                                ? Container(
                                                    height: height * 0.12,
                                                    width: width,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              spreadRadius: 2,
                                                              blurRadius: 3,
                                                              offset:
                                                                  Offset(0, 4))
                                                        ],
                                                        border: Border.all(
                                                            width: 1,
                                                            color: Colors
                                                                .grey.shade200),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 24,
                                                        top: 12,
                                                        bottom: 12,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: width * 0.6,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  dataMap[
                                                                      'number'],
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'SanFrancisco.Light',
                                                                      fontSize:
                                                                          11),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  dataMap[
                                                                      'name'],
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'SanFrancisco',
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  dataMap[
                                                                      'specialist'],
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'SanFrancisco.Light',
                                                                      fontSize:
                                                                          11),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  dataMap[
                                                                      'openHours'],
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'SanFrancisco.Regular',
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: width * 0.2,
                                                            child: Center(
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: 21,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ))
                                                : data[index].id ==
                                                        localStorage
                                                            .read("sessionId")
                                                    ? Container(
                                                        height: height * 0.12,
                                                        width: width,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade200,
                                                                      spreadRadius:
                                                                          2,
                                                                      blurRadius:
                                                                          3,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              4))
                                                                ],
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade200),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 24,
                                                            top: 12,
                                                            bottom: 12,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    width * 0.6,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      dataMap[
                                                                          'number'],
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontFamily:
                                                                              'SanFrancisco.Light',
                                                                          fontSize:
                                                                              11),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      dataMap[
                                                                          'name'],
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontFamily:
                                                                              'SanFrancisco',
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "Selected.",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontFamily: 'SanFrancisco.Light',
                                                                              fontSize: 11),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Icon(
                                                                            Icons
                                                                                .done,
                                                                            size:
                                                                                15,
                                                                            color:
                                                                                Colors.white)
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                width:
                                                                    width * 0.2,
                                                                child: Center(
                                                                  child: Icon(
                                                                      Icons
                                                                          .change_circle,
                                                                      size: 21,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ))
                                                    : Container(
                                                        height: height * 0.12,
                                                        width: width,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade200,
                                                                  spreadRadius:
                                                                      2,
                                                                  blurRadius: 3,
                                                                  offset:
                                                                      Offset(
                                                                          0, 4))
                                                            ],
                                                            border: Border.all(width: 1, color: Colors.grey.shade200),
                                                            borderRadius: BorderRadius.circular(5)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 24,
                                                            top: 12,
                                                            bottom: 12,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    width * 0.6,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      dataMap[
                                                                          'number'],
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'SanFrancisco.Light',
                                                                          fontSize:
                                                                              11),
                                                                    ),
                                                                    Spacer(),
                                                                    Text(
                                                                      dataMap[
                                                                          'name'],
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'SanFrancisco',
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    Spacer(),
                                                                    Text(
                                                                      dataMap[
                                                                          'specialist'],
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'SanFrancisco.Light',
                                                                          fontSize:
                                                                              11),
                                                                    ),
                                                                    Spacer(),
                                                                    Text(
                                                                      dataMap[
                                                                          'openHours'],
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'SanFrancisco.Regular',
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                width:
                                                                    width * 0.2,
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .arrow_forward_ios,
                                                                    size: 21,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ))));
                                  }),
                              Container(
                                margin: EdgeInsets.only(top: 18),
                                height: height * 0.055,
                                width: width * 0.5,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade200,
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(0, 2))
                                  ],
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade200),
                                ),
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  color: Colors.white,
                                  height: height * 0.055,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.grey.shade800,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Add More",
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey.shade800),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 21,
                                      ),
                                    ],
                                  ),
                                  onPressed: () => Get.toNamed(
                                      Routes.SERVICE_FORM,
                                      arguments: 'Vet'),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () => {
                                  localStorage.write('vetStatus', true),
                                  Get.toNamed(Routes.CREATE_ORDER,
                                      arguments: 'Vet'),
                                },
                                child: Container(
                                    height: height * 0.07,
                                    width: width * 0.85,
                                    decoration: BoxDecoration(
                                        color: Color(0xffF9813A),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade300,
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                              offset: Offset(0, 2))
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Confirm Session',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'SanFrancisco',
                                                  color: Colors.white)),
                                          Icon(
                                            Icons.done_rounded,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () => {
                                  localStorage.write('vetStatus', false),
                                  Get.toNamed(Routes.SERVICE_LIST)
                                },
                                child: Container(
                                    height: height * 0.07,
                                    width: width * 0.85,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade300,
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                              offset: Offset(0, 2))
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Back to Order',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'SanFrancisco',
                                                  color: Color(0xffF9813A))),
                                          const Icon(
                                            Icons.arrow_forward_rounded,
                                            color: Color(0xffF9813A),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ));
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      });
                }
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      )),
    );
  }
}
