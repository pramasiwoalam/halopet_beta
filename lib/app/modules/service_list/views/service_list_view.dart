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
    var groomingStatus = localStorage.read('grooming');
    var hotelStatus = localStorage.read('hotel');
    var vetStatus = localStorage.read('vetStatus');
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
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500, fontSize: 18),
              ),
              backgroundColor: Color(0xffF9813A),
              elevation: 0,
              centerTitle: true,
            ),
            body: Container(
              height: height,
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  margin: EdgeInsets.only(
                      top: height * 0.03,
                      left: width * 0.08,
                      right: width * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Create Your Service(s).',
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffF9813A))),
                      Text(
                          'Your petshop need atleast 1 service to register to our app. Please click the botton below to register your services.',
                          style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade700)),
                      SizedBox(
                        height: 15,
                      ),
                      groomingStatus == false
                          ? InkWell(
                              onTap: () => {
                                Get.toNamed(Routes.SERVICE_FORM,
                                    arguments: 'Grooming'),
                                // controller.createService()
                              },
                              child: Container(
                                height: height * 0.12,
                                width: width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: Offset(0, 3))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Grooming Service',
                                              style: GoogleFonts.inter(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey.shade700)),
                                          Text('Not yet registered.',
                                              style: GoogleFonts.inter(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade700))
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
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
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(0, 3))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Grooming Service',
                                            style: GoogleFonts.inter(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white)),
                                        Text('Registered.',
                                            style: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
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
                      SizedBox(
                        height: 15,
                      ),
                      hotelStatus == false
                          ? InkWell(
                              onTap: () => {
                                localStorage.write('serviceFlag', 0),
                                Get.toNamed(Routes.SERVICE_FORM,
                                    arguments: 'Hotel'),
                                print(
                                    'flag: ${localStorage.read('serviceFlag')}')
                              },
                              child: Container(
                                height: height * 0.12,
                                width: width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: Offset(0, 3))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Pet Hotel Service',
                                              style: GoogleFonts.inter(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey.shade700)),
                                          Text('Not yet registered.',
                                              style: GoogleFonts.inter(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade700))
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
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
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(0, 3))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Pet Hotel Service',
                                            style: GoogleFonts.inter(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white)),
                                        Text('Registered.',
                                            style: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
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
                      SizedBox(
                        height: 15,
                      ),
                      vetStatus == false
                          ? InkWell(
                              onTap: () => Get.toNamed(Routes.SESSION_LIST),
                              child: Container(
                                height: height * 0.12,
                                width: width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: Offset(0, 3))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Vet Session',
                                              style: GoogleFonts.inter(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey.shade700)),
                                          Text('Not yet registered.',
                                              style: GoogleFonts.inter(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade700))
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey.shade600,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () => Get.toNamed(Routes.SESSION_LIST),
                              child: Container(
                                height: height * 0.12,
                                width: width,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: Offset(0, 3))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Vet Session',
                                              style: GoogleFonts.inter(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white)),
                                          Text('Registered.',
                                              style: GoogleFonts.inter(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
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
                      InkWell(
                        onTap: () => {
                          if (localStorage.read('grooming') == true)
                            {
                              controller.createPetshop(),
                              Get.toNamed(Routes.HOMEPAGE)
                            }
                          else if (localStorage.read('vetStatus') == true)
                            {
                              controller.createPetshop(),
                              Get.toNamed(Routes.HOMEPAGE)
                            }
                        },
                        child: Container(
                            height: height * 0.07,
                            width: width,
                            decoration: BoxDecoration(
                                color: Color(0xffF9813A),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(0, 2))
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Register',
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
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
                          controller.registerCancellation(
                              localStorage.read('tempPetshopId')),
                          Get.toNamed(Routes.HOMEPAGE)
                        },
                        child: Container(
                            height: height * 0.07,
                            width: width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(0, 2))
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Cancel Registration',
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
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
                  ),
                ),
              ),
            )));
  }
}
