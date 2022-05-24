import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/petshop_detail/controllers/petshop_detail_controller.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/choose_pet_controller.dart';

class ChoosePetView extends GetView<ChoosePetController> {
  var localStorage = GetStorage();
  final detailC = Get.put(PetshopDetailController());

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
            'Choose your pet',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Container(
          height: height,
          width: width,
          child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getUser(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                if (data['pets'] == null) {
                  Get.toNamed(Routes.PET_LIST);
                  return SizedBox();
                } else {
                  List petsArray = data['pets'];
                  if (petsArray.isEmpty) {
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
                        stream: controller.getPets(),
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
                                          Get.toNamed(Routes.CREATE_ORDER,
                                              arguments: 'Grooming'),
                                          localStorage.write(
                                              'deliveryCharge', null),
                                          localStorage.write(
                                              'petId', data[index].id)
                                        },
                                        child: Container(
                                            height: height * 0.21,
                                            width: width,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey.shade300),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0,
                                                          bottom: 10,
                                                          left: 6),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            bottom: 8,
                                                            left: 10),
                                                    child: Container(
                                                      height: height * 0.18,
                                                      width: width * 0.3,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                                '${dataMap['img']}')),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 7.0,
                                                          bottom: 10,
                                                          left: 15),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 9, bottom: 10),
                                                    child: Container(
                                                      height: height * 0.2,
                                                      width: width * 0.55,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  '${dataMap['name']}',
                                                                  style: GoogleFonts.roboto(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          17,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade800)),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Icon(
                                                                dataMap['gender'] ==
                                                                        'Male'
                                                                    ? Icons.male
                                                                    : Icons
                                                                        .female,
                                                                color: dataMap[
                                                                            'gender'] ==
                                                                        'Male'
                                                                    ? Colors
                                                                        .blue
                                                                    : Colors
                                                                        .pink,
                                                                size: 20,
                                                              )
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                              'Hello! My Name is ${dataMap['name']}. I was adopted/ born on ${dataMap['birth']}.',
                                                              style: GoogleFonts.roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade800,
                                                                  fontSize:
                                                                      13)),
                                                          Spacer(),
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .baby_changing_station,
                                                                color: Colors
                                                                    .orange,
                                                                size: 19,
                                                              ),
                                                              const SizedBox(
                                                                width: 6,
                                                              ),
                                                              Text(
                                                                  "${dataMap['age']} months.",
                                                                  style: GoogleFonts.roboto(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          13)),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .monitor_weight,
                                                                color: Colors
                                                                    .grey
                                                                    .shade700,
                                                                size: 19,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '${dataMap['weight']} kg(s).',
                                                                style: GoogleFonts
                                                                    .roboto(
                                                                        fontSize:
                                                                            13),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            height:
                                                                height * 0.03,
                                                            width: width * 0.23,
                                                            color: Colors
                                                                .blue.shade300,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Center(
                                                                child: Text(
                                                                  dataMap[
                                                                      'species'],
                                                                  style: GoogleFonts.roboto(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      );
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      color: Colors.grey.shade200,
                                      height: height * 0.05,
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
                                      onPressed: () =>
                                          Get.toNamed(Routes.PET_FORM),
                                    ),
                                  ),
                                )
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
        )));
  }
}
