import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/edit_service_controller.dart';

class EditVetService extends StatelessWidget {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  final controller = Get.put(EditServiceController());
  final serviceController = Get.put(EditServiceController());
  Map<String, dynamic> formData = {
    'number': null,
    'day': null,
    'name': null,
    'openHoursStart': null,
    'openHoursEnd': null,
    'specialist': null,
    'desc': null,
    'yearsActive': null
  };

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
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
                  serviceController.sessionList.isEmpty
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
                                      "You don't have any session registered. Please register before create this vet service.",
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
                                                arguments: 'Vet',
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
                                itemCount: serviceController.sessionList.length,
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: height * 0.18,
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
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Container(
                                            width: width * 0.32,
                                            height: height,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: const DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      'assets/images/pet-hotel.jpg')),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: width * 0.55,
                                            height: height,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Spacer(),
                                                Text(
                                                  serviceController
                                                          .packageHotelList[
                                                      index]['name'],
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'SanFrancisco',
                                                      fontSize: 14),
                                                ),
                                                Spacer(),
                                                Text(
                                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vehicula vestibulum faucibus.',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'SanFrancisco.Light',
                                                      fontSize: 12),
                                                ),
                                                Spacer(),
                                                Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.pets,
                                                      size: 13,
                                                      color: Colors.orange,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Dog, Cat',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'SanFrancisco.Light',
                                                          fontSize: 11),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.price_change,
                                                      size: 13,
                                                      color: Colors.orange,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '100.000',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'SanFrancisco',
                                                          fontSize: 13),
                                                    ),
                                                    Text(
                                                      ' / night',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'SanFrancisco.Light',
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
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
                                    arguments: 'Vet',
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
                              if (serviceController.packageHotelList.isNotEmpty)
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
                                        'You need to created atleast one session before you create this service.',
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
                              Get.toNamed(Routes.SERVICE_LIST),
                              // controller.cancellation(
                              //     localStorage.read('savedPetshopId'),
                              //     localStorage.read('savedServiceId')),
                              localStorage.write('serviceFlag', 0),
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
