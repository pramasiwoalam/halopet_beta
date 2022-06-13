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
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 19),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
          centerTitle: true,
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
                          Get.toNamed(Routes.CREATE_ORDER,
                              arguments: 'Grooming'),
                          localStorage.write('packageData', dataMap),
                          localStorage.write('packageId', data[index].id),
                          groomingController.packageFlag = '1'.obs,
                          groomingController.packageName = dataMap['name']
                        },
                        child: Container(
                          height: height * 0.15,
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
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: Icon(
                                          Icons.info,
                                          color: Colors.orange,
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
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
                                            Text(
                                              dataMap['desc'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.grey.shade800,
                                                  fontFamily:
                                                      'SanFrancisco.Light',
                                                  fontSize: 12),
                                            )
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
                                        dataMap['price'],
                                        style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontFamily: 'SanFrancisco.Light',
                                            fontSize: 14),
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
