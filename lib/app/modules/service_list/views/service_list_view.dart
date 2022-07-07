import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/service_list_controller.dart';

class ServiceListView extends GetView<ServiceListController> {
  var localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var groomingStatus = localStorage.read('groomingFlag');
    var hotelStatus = localStorage.read('hotelFlag');
    var vetStatus = localStorage.read('vetFlag');
    final controller = Get.put(ServiceListController());

    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                'Create Services',
                style: TextStyle(
                    fontFamily: 'SanFrancisco',
                    fontSize: 16,
                    color: Colors.grey.shade800),
              ),
              leading: Icon(
                Icons.abc,
                color: Colors.grey.shade200,
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Container(
              height: height,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  groomingStatus == false
                      ? InkWell(
                          onTap: () => {
                            Get.toNamed(Routes.SERVICE_FORM,
                                arguments: 'Grooming'),
                            controller.createGroomingService()
                          },
                          child: Container(
                            height: height * 0.12,
                            width: width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(0, 3)),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Grooming Service',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'SanFrancisco',
                                              color: Colors.grey.shade700)),
                                      Text('Not yet registered.',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: 'SanFrancisco.Light',
                                              color: Colors.grey.shade700))
                                    ],
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 25,
                                    color: Colors.grey.shade600,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: height * 0.12,
                          width: width,
                          decoration: BoxDecoration(
                              color: Color(0xffF9813A),
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 3))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Grooming Service',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'SanFrancisco',
                                            color: Colors.white)),
                                    Text('Registered.',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: 'SanFrancisco.Light',
                                            color: Colors.white))
                                  ],
                                ),
                                Icon(
                                  Icons.done_rounded,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                  hotelStatus == false
                      ? InkWell(
                          onTap: () => {
                            localStorage.write('serviceFlag', 0),
                            Get.toNamed(Routes.SERVICE_FORM,
                                arguments: 'Hotel'),
                            controller.createHotelService()
                          },
                          child: Container(
                            height: height * 0.12,
                            width: width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(0, 3))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Pet Hotel Service',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'SanFrancisco',
                                              color: Colors.grey.shade700)),
                                      Text('Not yet registered.',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: 'SanFrancisco.Light',
                                              color: Colors.grey.shade700))
                                    ],
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 25,
                                    color: Colors.grey.shade600,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: height * 0.12,
                          width: width,
                          decoration: BoxDecoration(
                              color: Color(0xffF9813A),
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 3))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Pet Hotel Service',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'SanFrancisco',
                                            color: Colors.white)),
                                    Text('Registered.',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: 'SanFrancisco.Light',
                                            color: Colors.white))
                                  ],
                                ),
                                Icon(
                                  Icons.done_rounded,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                  vetStatus == false
                      ? InkWell(
                          onTap: () => {
                            localStorage.write('vetFlag', 0),
                            Get.toNamed(Routes.SERVICE_FORM, arguments: 'Vet'),
                            controller.createVetService()
                          },
                          child: Container(
                            height: height * 0.12,
                            width: width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(0, 3))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Vet Session',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'SanFrancisco',
                                              color: Colors.grey.shade700)),
                                      Text('Not yet registered.',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: 'SanFrancisco.Light',
                                              color: Colors.grey.shade700)),
                                    ],
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 25,
                                    color: Colors.grey.shade600,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () => {
                            localStorage.write('serviceFlag', 0),
                            Get.toNamed(Routes.SERVICE_FORM, arguments: 'Vet'),
                          },
                          child: Container(
                            height: height * 0.12,
                            width: width,
                            decoration: BoxDecoration(
                                color: Color(0xffF9813A),
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(0, 3))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Vet Session',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'SanFrancisco',
                                              color: Colors.white)),
                                      Text('Registered.',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: 'SanFrancisco.Light',
                                              color: Colors.white))
                                    ],
                                  ),
                                  Icon(
                                    Icons.done_rounded,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      height: size.height * 0.07,
                      width: size.width * 0.9,
                      color: Colors.transparent,
                      child: ElevatedButton(
                        onPressed: () => {
                          if (groomingStatus == true ||
                              vetStatus == true ||
                              hotelStatus == true)
                            {
                              controller.createPetshop(),
                              Get.toNamed(Routes.HOMEPAGE)
                            }
                          else
                            {
                              Get.dialog(AlertDialog(
                                title: Text(
                                  'Alert',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco', fontSize: 14),
                                ),
                                titlePadding: EdgeInsets.only(
                                    left: 26, right: 26, top: 30),
                                contentPadding: EdgeInsets.only(
                                    left: 26, right: 26, top: 16, bottom: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                content: Text(
                                    'You need to fill atleast one service, before you create your own petshop.',
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
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          primary: Color(0xffF9813A),
                          shape: StadiumBorder(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Register',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'SanFrancisco',
                                      color: Colors.white)),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Container(
                      height: size.height * 0.07,
                      width: size.width * 0.9,
                      color: Colors.transparent,
                      child: ElevatedButton(
                        onPressed: () => {
                          controller.registerCancellation(
                              localStorage.read('tempPetshopId')),
                          Get.toNamed(Routes.HOMEPAGE)
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          primary: Colors.white,
                          shape: StadiumBorder(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Cancel Registration',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'SanFrancisco',
                                      color: Color(0xffF9813A))),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: Color(0xffF9813A),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
