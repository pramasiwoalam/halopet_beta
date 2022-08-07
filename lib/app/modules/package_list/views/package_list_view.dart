import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../../grooming_order/controllers/grooming_order_controller.dart';
import '../controllers/package_list_controller.dart';

class PackageListView extends GetView<PackageListController> {
  final orderController = Get.put(PackageListController());
  final groomingController = Get.put(GroomingOrderController());
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var serviceId = localStorage.read('selectedServiceId');
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Choose the package',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 17),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
        ),
        body: StreamBuilder<QuerySnapshot<Object?>>(
            stream: orderController.getPackageByServiceId(serviceId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var data = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var dataMap = data[index].data() as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(6),
                      child: InkWell(
                        onTap: () => {
                          Get.dialog(AlertDialog(
                            title: const Text(
                              'Delivery Option',
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco', fontSize: 14),
                            ),
                            titlePadding:
                                EdgeInsets.only(left: 26, right: 26, top: 30),
                            contentPadding: const EdgeInsets.only(
                                left: 26, right: 26, top: 16, bottom: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            content: const Text(
                                'Do you want to order with delivery?',
                                style: TextStyle(
                                    fontFamily: 'SanFrancisco.Light',
                                    fontSize: 12)),
                            actionsPadding: EdgeInsets.only(top: 6, bottom: 2),
                            actions: [
                              TextButton(
                                  onPressed: () => {
                                        Get.back(),
                                        Get.toNamed(Routes.DELIVERY_LIST,
                                            arguments: "Hotel")
                                      },
                                  child: const Text(
                                    'Yes, with delivery',
                                    style: TextStyle(
                                        fontFamily: 'SanFrancisco.Light',
                                        fontSize: 13,
                                        color: Colors.orange),
                                  )),
                              TextButton(
                                  onPressed: () => {
                                        Get.back(),
                                        Get.toNamed(Routes.CREATE_ORDER,
                                            arguments: 'Grooming'),
                                        localStorage.write(
                                            'packageData', dataMap),
                                        localStorage.write(
                                            'packageId', data[index].id),
                                        groomingController.packageName =
                                            dataMap['name']
                                      },
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                        fontFamily: 'SanFrancisco',
                                        fontSize: 13,
                                        color: Colors.orange),
                                  )),
                            ],
                          ))
                        },
                        child: Container(
                          height: height * 0.14,
                          width: width * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 0.8, color: Colors.grey.shade300),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
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
                                  top: 12, bottom: 12, left: 32, right: 32),
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
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dataMap['name'],
                                              style: TextStyle(
                                                  color: Colors.grey.shade800,
                                                  fontFamily: 'SanFrancisco',
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              dataMap['desc'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.grey.shade800,
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
                                                  color: Colors.orange,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Cat, Dog',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
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
                                                  color: Colors.orange,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '1 hour',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
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
                                        'Rp. ${dataMap['price']}',
                                        style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontFamily: 'SanFrancisco.Light',
                                            fontSize: 13),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
