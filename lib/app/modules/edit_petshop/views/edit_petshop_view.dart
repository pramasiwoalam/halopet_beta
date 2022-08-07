import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/order/views/order_approval_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import 'package:money_formatter/money_formatter.dart';

import '../controllers/edit_petshop_controller.dart';

class EditPetshopView extends GetView<EditPetshopController> {
  @override
  Widget build(BuildContext context) {
    final localStorage = GetStorage();
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var petshopId = localStorage.read('tempPetshopId');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Edit Petshop',
          style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 15),
        ),
        backgroundColor: Color(0xff2596BE),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getPetshop(petshopId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var dataMap = snapshot.data!.data() as Map<String, dynamic>;
                var isOpen = dataMap['isOpen'] == true
                    ? controller.isOpen.value = true
                    : controller.isOpen.value = false;

                localStorage.write('tempPetshopData', dataMap);
                return Column(
                  children: [
                    Container(
                      height: height * 0.08,
                      width: width,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.grey.shade200),
                        color: Colors.white,
                      ),
                      child: FlatButton(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Petshop Status',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco',
                                      fontSize: 14,
                                      color: Colors.grey.shade800)),
                              Obx(
                                () => Row(
                                  children: [
                                    Text(
                                        controller.isOpen.value == true
                                            ? 'OPEN'
                                            : 'CLOSED',
                                        style: TextStyle(
                                            fontFamily: 'SanFrancisco',
                                            fontSize: 15,
                                            color:
                                                controller.isOpen.value == true
                                                    ? Color(0xff2596BE)
                                                    : Colors.red)),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Icon(
                                      Icons.change_circle,
                                      size: 18,
                                      color: Colors.grey.shade600,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () => {
                          Get.dialog(AlertDialog(
                            title: const Text(
                              'Confirmation',
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco', fontSize: 14),
                            ),
                            titlePadding:
                                EdgeInsets.only(left: 26, right: 26, top: 30),
                            contentPadding: const EdgeInsets.only(
                                left: 26, right: 26, top: 16, bottom: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            content: Text(
                                controller.isOpen.value == false
                                    ? 'Are you sure want to open this petshop? Confirm to continue.'
                                    : 'Are you sure want to closed this petshop? Confirm to continue.',
                                style: TextStyle(
                                    fontFamily: 'SanFrancisco.Light',
                                    fontSize: 12)),
                            actionsPadding:
                                EdgeInsets.only(right: 15, top: 6, bottom: 2),
                            actions: [
                              TextButton(
                                  onPressed: () => {Get.back()},
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                        fontFamily: 'SanFrancisco.Light',
                                        fontSize: 13,
                                        color: Colors.orange),
                                  )),
                              TextButton(
                                  onPressed: () => {
                                        Get.back(),
                                        controller.isOpen.value == true
                                            ? controller.isOpen.value = false
                                            : controller.isOpen.value = true,
                                        controller.updateIsOpen(
                                            controller.isOpen.value, petshopId)
                                      },
                                  child: Text(
                                    'Confirm',
                                    style: TextStyle(
                                        fontFamily: 'SanFrancisco',
                                        fontSize: 13,
                                        color: Colors.orange),
                                  )),
                            ],
                          ))
                        },
                      ),
                    ),
                    Container(
                      height: height * 0.08,
                      width: width,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.grey.shade200),
                        color: Colors.white,
                      ),
                      child: FlatButton(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Edit Petshop Information',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco',
                                      fontSize: 14,
                                      color: Colors.grey.shade800)),
                            ],
                          ),
                        ),
                        onPressed: () => {
                          Get.toNamed(
                            Routes.EDIT_PETSHOP_FORM,
                          )
                        },
                      ),
                    ),
                    Container(
                      height: height * 0.08,
                      width: width,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.grey.shade200),
                        color: Colors.white,
                      ),
                      child: FlatButton(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Edit Services',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco',
                                      fontSize: 14,
                                      color: Colors.grey.shade800)),
                              Icon(
                                Icons.abc,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        onPressed: () => {
                          controller.dropdown.value == false
                              ? controller.dropdown.value = true
                              : controller.dropdown.value = false
                        },
                      ),
                    ),
                    StreamBuilder<QuerySnapshot<Object?>>(
                        stream: controller.getService(petshopId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            var data = snapshot.data!.docs;
                            return ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  var serviceData = data[index].data()
                                      as Map<String, dynamic>;

                                  return Column(
                                    children: [
                                      dataMap['groomingService'] == true
                                          ? Container(
                                              height: height * 0.08,
                                              width: width,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade200),
                                                color: Colors.white,
                                              ),
                                              child: FlatButton(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16, right: 16),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.edit,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(
                                                          'Edit Grooming Service',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 14,
                                                              color: Colors.grey
                                                                  .shade800)),
                                                    ],
                                                  ),
                                                ),
                                                onPressed: () => {
                                                  localStorage.write(
                                                      'editServiceId',
                                                      data[index].id),
                                                  Get.toNamed(
                                                      Routes.EDIT_SERVICE,
                                                      arguments:
                                                          'Grooming Service'),
                                                },
                                              ),
                                            )
                                          : Container(
                                              height: height * 0.08,
                                              width: width,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade200),
                                                color: Colors.white,
                                              ),
                                              child: FlatButton(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16, right: 16),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(
                                                          'Add Grooming Service',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 14,
                                                              color: Colors.grey
                                                                  .shade800)),
                                                    ],
                                                  ),
                                                ),
                                                onPressed: () => {
                                                  localStorage.write(
                                                      'editServiceId',
                                                      data[index].id),
                                                  Get.toNamed(
                                                      Routes.EDIT_SERVICE,
                                                      arguments:
                                                          'Grooming Service'),
                                                },
                                              ),
                                            ),
                                      dataMap['vetService'] == true
                                          ? Container(
                                              height: height * 0.08,
                                              width: width,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade200),
                                                color: Colors.white,
                                              ),
                                              child: FlatButton(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16, right: 16),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.edit,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text('Edit Vet Service',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 14,
                                                              color: Colors.grey
                                                                  .shade800)),
                                                    ],
                                                  ),
                                                ),
                                                onPressed: () => {
                                                  localStorage.write(
                                                      'editServiceId',
                                                      data[index].id),
                                                  Get.toNamed(
                                                      Routes.EDIT_SERVICE,
                                                      arguments: 'Vet Service'),
                                                },
                                              ),
                                            )
                                          : Container(
                                              height: height * 0.08,
                                              width: width,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade200),
                                                color: Colors.white,
                                              ),
                                              child: FlatButton(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16, right: 16),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text('Add Vet Service',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 14,
                                                              color: Colors.grey
                                                                  .shade800)),
                                                    ],
                                                  ),
                                                ),
                                                onPressed: () => {
                                                  localStorage.write(
                                                      'editServiceId',
                                                      data[index].id),
                                                  Get.toNamed(
                                                      Routes.EDIT_SERVICE,
                                                      arguments:
                                                          serviceData['name']),
                                                },
                                              ),
                                            ),
                                      dataMap['hotelService'] == true
                                          ? Container(
                                              height: height * 0.08,
                                              width: width,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade200),
                                                color: Colors.white,
                                              ),
                                              child: FlatButton(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16, right: 16),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.edit,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text('Edit Hotel Service',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 14,
                                                              color: Colors.grey
                                                                  .shade800)),
                                                    ],
                                                  ),
                                                ),
                                                onPressed: () => {
                                                  localStorage.write(
                                                      'editServiceId',
                                                      data[index].id),
                                                  Get.toNamed(
                                                      Routes.EDIT_SERVICE,
                                                      arguments:
                                                          serviceData['name']),
                                                },
                                              ),
                                            )
                                          : Container(
                                              height: height * 0.08,
                                              width: width,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade200),
                                                color: Colors.white,
                                              ),
                                              child: FlatButton(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16, right: 16),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text('Add Hotel Service',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 14,
                                                              color: Colors.grey
                                                                  .shade800)),
                                                    ],
                                                  ),
                                                ),
                                                onPressed: () => {
                                                  localStorage.write(
                                                      'editServiceId',
                                                      data[index].id),
                                                  Get.toNamed(
                                                      Routes.EDIT_SERVICE,
                                                      arguments:
                                                          serviceData['name']),
                                                },
                                              ),
                                            )
                                    ],
                                  );
                                });
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                        onPressed: () => {
                              Get.dialog(AlertDialog(
                                title: Text(
                                  'Update Confirmation',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco', fontSize: 14),
                                ),
                                titlePadding: EdgeInsets.only(
                                    left: 26, right: 26, top: 30),
                                contentPadding: EdgeInsets.only(
                                    left: 26, right: 26, top: 16, bottom: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                content: Text(
                                    'Are you the update data is correct? Confirm if you want to create this booking.',
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
                                            fontFamily: 'SanFrancisco.Light',
                                            fontSize: 13,
                                            color: Color(0xff2596BE)),
                                      )),
                                  TextButton(
                                      onPressed: () => {},
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                            fontFamily: 'SanFrancisco',
                                            fontSize: 13,
                                            color: Color(0xff2596BE)),
                                      )),
                                ],
                              ))
                            },
                        child: Container(
                            height: height * 0.07,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 3,
                                      blurRadius: 4,
                                      offset: Offset(0, 4))
                                ],
                                color: Color(0xff2596BE),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Save",
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
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
