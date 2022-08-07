import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/order/views/order_approval_view.dart';
import 'package:halopet_beta/app/modules/package_form/views/package_grooming.dart';
import 'package:halopet_beta/app/modules/service_list/controllers/service_list_controller.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/service_form_controller.dart';

class GroomingService extends StatelessWidget {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  final controller = Get.put(ServiceListController());
  final serviceController = Get.put(ServiceFormController());
  Map<String, dynamic> formData = {'name': null, 'desc': null};

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var localStorage = GetStorage();

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Form(
        key: form,
        child: Column(
          children: [
            Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  serviceController.packageGroomingList.isEmpty
                      ? Container(
                          height: height * 0.25,
                          width: width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade300)),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "You don't have any grooming package registered. Please register before create this grooming service.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco.Light',
                                          color: Colors.grey.shade700,
                                          fontSize: 13),
                                    ),
                                    TextButton(
                                        onPressed: () => {
                                              Get.toNamed(
                                                Routes.PACKAGE_FORM,
                                                arguments: 'Grooming',
                                              ),
                                            },
                                        child: Text(
                                          'Register here.',
                                          style: TextStyle(
                                              fontFamily: 'SanFrancisco',
                                              color: Color(0xffF9813A),
                                              fontSize: 13),
                                        ))
                                  ]),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            ListView.builder(
                                itemCount: serviceController
                                    .packageGroomingList.length,
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: height * 0.14,
                                    width: width * 0.8,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 0.8,
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade200,
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              offset: Offset(1, 2))
                                        ]),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12,
                                            bottom: 12,
                                            left: 32,
                                            right: 32),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: width * 0.35,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        serviceController
                                                                .packageGroomingList[
                                                            index]['name'],
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade800,
                                                            fontFamily:
                                                                'SanFrancisco',
                                                            fontSize: 14),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'Detailing',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade800,
                                                            fontFamily:
                                                                'SanFrancisco.Light',
                                                            fontSize: 11),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.pets,
                                                            size: 13,
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'Cat, Dog',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade800,
                                                                fontFamily:
                                                                    'SanFrancisco.Light',
                                                                fontSize: 11),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.timer,
                                                            size: 13,
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            '1 hour',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade800,
                                                                fontFamily:
                                                                    'SanFrancisco.Light',
                                                                fontSize: 11),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            VerticalDivider(
                                              color: Colors.grey.shade300,
                                              thickness: 1,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.monetization_on,
                                                  color: Colors.orange,
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Rp. 100.000',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontFamily:
                                                          'SanFrancisco.Light',
                                                      fontSize: 13),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                            Container(
                              height: height * 0.07,
                              width: width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade300),
                              ),
                              child: FlatButton(
                                onPressed: () => {
                                  Get.toNamed(
                                    Routes.PACKAGE_FORM,
                                    arguments: 'Grooming',
                                  ),
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_rounded,
                                      size: 18,
                                      color: Colors.grey.shade700,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Add more',
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco',
                                          fontSize: 13,
                                          color: Colors.grey.shade700),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                  Container(
                    height: height * 0.08,
                    width: width,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      color: Colors.white,
                    ),
                    child: FlatButton(
                        onPressed: () => {
                              if (serviceController
                                  .packageGroomingList.isNotEmpty)
                                {
                                  localStorage.write('groomingFlag', true),
                                  Get.toNamed(Routes.SERVICE_LIST)
                                }
                              else
                                {
                                  Get.dialog(AlertDialog(
                                    title: Text(
                                      'Alert',
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
                                        'You need to created atleast one grooming package before you create this service.',
                                        style: TextStyle(
                                            fontFamily: 'SanFrancisco.Light',
                                            fontSize: 12)),
                                    actionsPadding: EdgeInsets.only(
                                        right: 12, top: 6, bottom: 2),
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
                            },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Register",
                                  style: TextStyle(
                                    fontFamily: 'SanFrancisco',
                                    fontSize: 13,
                                    color: Colors.grey.shade800,
                                  )),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey.shade800,
                                size: 18,
                              )
                            ],
                          ),
                        )),
                  ),
                  Container(
                    height: height * 0.08,
                    width: width,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      color: Colors.white,
                    ),
                    child: FlatButton(
                        onPressed: () => {
                              Get.toNamed(Routes.SELLER_HOME),

                              localStorage.write('serviceFlag', 0),
                              // localStorage.write('groomingFlag', 1)
                            },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Back to Service List",
                                  style: TextStyle(
                                    fontFamily: 'SanFrancisco',
                                    fontSize: 13,
                                    color: Colors.grey.shade800,
                                  )),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey.shade800,
                                size: 18,
                              )
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
