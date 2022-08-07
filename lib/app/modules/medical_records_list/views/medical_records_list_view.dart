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

import '../controllers/medical__records_list_controller.dart';

class MedicalRecordsListView extends GetView<MedicalRecordsListController> {
  final messageC = TextEditingController();
  var arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    var tempId = localStorage.read('temporaryPetId');
    print('TEMPPPPID$tempId');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Medical Records List',
          style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 15),
        ),
        backgroundColor: Color(0xffF9813A),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getPet(arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            if (data['isMedical'] == false) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height / 4,
                      ),
                      Text(
                          "You dont have any registered medical records. Please register first",
                          style: TextStyle(
                              fontFamily: 'SanFrancisco.Light', fontSize: 14)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: width * 0.25,
                        height: width * 0.20,
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
                                  size: 22,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('Register',
                                    style: TextStyle(
                                        fontFamily: 'SanFrancisco.Regular',
                                        fontSize: 12,
                                        color: Colors.grey.shade800))
                              ],
                            ),
                          ),
                          onPressed: () =>
                              Get.toNamed(Routes.MEDICAL_RECORDS_FORM),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return StreamBuilder<QuerySnapshot<Object?>>(
                  stream: controller.getMedicalRecords(tempId ?? arguments),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var data = snapshot.data!.docs;
                      return Column(
                        children: [
                          ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                var dataMap =
                                    data[index].data() as Map<String, dynamic>;

                                return InkWell(
                                    onTap: () => {},
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6, right: 6, top: 6),
                                        child: Container(
                                            height: height * 0.14,
                                            width: width,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Colors.grey.shade200,
                                                      spreadRadius: 2,
                                                      blurRadius: 3,
                                                      offset: Offset(0, 4))
                                                ],
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade200),
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          dataMap['date'],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 10),
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        Text(
                                                          dataMap['info'],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco',
                                                              fontSize: 15),
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        Text(
                                                          'Checked by: ${dataMap['author']}',
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'SanFrancisco.Light',
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ))));
                              }),
                          Container(
                            height: height * 0.09,
                            width: width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 10),
                              child: FlatButton(
                                padding: EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: Colors.grey.shade200,
                                height: height * 0.05,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: 19,
                                      color: Colors.grey.shade800,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text("Add More",
                                          style: TextStyle(
                                              fontFamily: 'SanFrancisco.Light',
                                              fontSize: 12)),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                    ),
                                  ],
                                ),
                                onPressed: () => Get.toNamed(
                                  Routes.MEDICAL_RECORDS_FORM,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              height: size.height * 0.07,
                              width: size.width * 0.9,
                              color: Colors.transparent,
                              child: ElevatedButton(
                                onPressed: () => {Get.toNamed(Routes.HOMEPAGE)},
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  primary: Color(0xffF9813A),
                                  shape: StadiumBorder(),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}
