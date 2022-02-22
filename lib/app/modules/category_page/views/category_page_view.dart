import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/category_page_controller.dart';

class CategoryPageView extends GetView<CategoryPageController> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var value = Get.arguments;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.red,
                height: height * 0.2,
                width: width,
              ),
              value == 1
                  ? Container(
                      margin: EdgeInsets.only(top: 20),
                      height: height * 0.055,
                      width: width,
                      child: Center(
                        child: Column(
                          children: [
                            Text('Petshop that serves Grooming',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600, fontSize: 17)),
                            Text(
                              'Loved & highly-reviewed petshop, by and for pets.',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : value == 2
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: height * 0.055,
                          width: width,
                          child: Center(
                            child: Column(
                              children: [
                                Text('Happy Pet, Happy Us!',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17)),
                                Text(
                                  'Loved & highly-reviewed petshop, by and for pets.',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 20),
                          height: height * 0.055,
                          width: width,
                          child: Center(
                            child: Column(
                              children: [
                                Text('Petshop that gives comfort for your pet',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17)),
                                Text(
                                  'Loved & highly-reviewed petshop, by and for pets.',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
              Container(
                child: StreamBuilder<QuerySnapshot<Object?>>(
                    stream: controller.streamData(Get.arguments),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        var data = snapshot.data!.docs;
                        return ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () => Get.toNamed(
                                      Routes.PETSHOP_DETAIL,
                                      arguments: data[index].id),
                                  child: Container(
                                    // color: Colors.red,
                                    height: height * 0.3,
                                    width: width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            height: height * 0.18,
                                            width: width * 0.90,
                                            // color: Colors.blue,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                              ),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/images/petshop-1.jpg'),
                                              ),
                                            )),
                                        Container(
                                          height: height * 0.12,
                                          width: width * 0.90,
                                          // color: Colors.yellow,
                                          decoration: const BoxDecoration(
                                            color: Color(0xfff0f0f0),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${(data[index].data() as Map<String, dynamic>)["petshopName"]}',
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 5),
                                                      width: 55,
                                                      height: 30,
                                                      // color: Colors.green,
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text('5.0',
                                                              style: GoogleFonts.roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white)),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          const Icon(
                                                            Icons.star,
                                                            color: Colors.white,
                                                            size: 15,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  'Jakarta, Indonesia',
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 13),
                                                ),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.verified_rounded,
                                                      color: Color(0xff3CBA54),
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text('Grooming'),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Icon(
                                                      Icons.verified_rounded,
                                                      color: Color(0xff3CBA54),
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text('Pet Hotel'),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Icon(
                                                      Icons.verified_rounded,
                                                      color: Color(0xff3CBA54),
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text('Vet'),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ],
          ),
        ));
  }
}
