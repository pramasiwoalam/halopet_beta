import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/package_form/views/package_grooming.dart';
import 'package:halopet_beta/app/modules/service_form/views/service_form_grooming.dart';
import 'package:halopet_beta/app/modules/service_form/views/service_form_hotel.dart';
import 'package:halopet_beta/app/modules/service_form/views/service_form_vet.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/medical_list_reg_controller.dart';

class MedicalListRegView extends GetView<MedicalListRegController> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var localStorage = GetStorage();
    final controller = Get.put(MedicalListRegController());

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Service Registration',
            style: TextStyle(
                fontFamily: 'SanFrancisco',
                fontSize: 15,
                color: Colors.grey.shade800),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
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
                    controller.medicalList.isEmpty
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
                                                // controller.createDefaultSession(),
                                                Get.toNamed(
                                                  Routes.MEDICAL_LIST_FORM,
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
                                  itemCount: controller.medicalList.length,
                                  physics: const ClampingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        height: height * 0.14,
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
                                                width: 1,
                                                color: Colors.grey.shade200),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 30,
                                            top: 12,
                                            bottom: 12,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: width * 0.65,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Service Name',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'SanFrancisco.Light',
                                                          fontSize: 10),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      controller.medicalList[
                                                          index]['name'],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'SanFrancisco',
                                                          fontSize: 15),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      controller.medicalList[
                                                          index]['desc'],
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'SanFrancisco.Light',
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.2,
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 21,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ));
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
                                      Routes.MEDICAL_LIST_FORM,
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
                        border:
                            Border.all(width: 1, color: Colors.grey.shade300),
                        color: Colors.white,
                      ),
                      child: FlatButton(
                          onPressed: () => {
                                if (controller.medicalList.isNotEmpty)
                                  {
                                    localStorage.write('vetFlag', true),
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
                                          'You need to created atleast one room before you create this service.',
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
                        border:
                            Border.all(width: 1, color: Colors.grey.shade300),
                        color: Colors.white,
                      ),
                      child: FlatButton(
                          onPressed: () => {
                                Get.toNamed(Routes.SERVICE_LIST),
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
        ));
  }
}
