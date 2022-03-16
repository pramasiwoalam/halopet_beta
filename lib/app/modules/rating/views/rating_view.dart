import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/rating_controller.dart';

class RatingView extends GetView<RatingController> {
  final messageC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    var orderId = Get.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Rate your order',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        backgroundColor: Color(0xffF9813A),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Container(
            height: height / 4,
            width: width,
            color: Color(0xffF9813A),
          ),
          Container(
              margin: EdgeInsets.only(top: height * 0.01),
              width: width,
              height: height,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    FutureBuilder<DocumentSnapshot<Object?>>(
                        future: controller.getOrder(orderId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            var data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            controller.petshopId = data['petshopId'];
                            controller.service = data['bookingType'];
                            return FutureBuilder<DocumentSnapshot<Object?>>(
                                future: controller.getUser(data['userId']),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    var data = snapshot.data!.data()
                                        as Map<String, dynamic>;
                                    controller.userName = data['name'];
                                    return Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Thank you for your order.',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey.shade700,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 24.0, top: 8, right: 24),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Order from:',
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  'Dita Genday Petshop',
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 15),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 24.0, top: 8, right: 24),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Service:',
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  'Grooming',
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 15),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                });
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                    Container(
                      width: width * 0.82,
                      height: height * 0.16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(0, 2))
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 38.0, top: 25, bottom: 10),
                            child: Text(
                              'How was the service?',
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey.shade800),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBar.builder(
                                  glowRadius: 10,
                                  initialRating: 0,
                                  minRating: 1,
                                  unratedColor: Colors.grey.shade300,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemSize: 45,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Color(0xffF9813A),
                                    size: 50,
                                  ),
                                  onRatingUpdate: (rating) {
                                    controller.rating = rating;
                                  },
                                )
                              ]),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: width * 0.82,
                      height: height * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(0, 2))
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 26.0, top: 30, bottom: 14),
                            child: Text(
                              'Let us know what your thought.',
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey.shade800),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 4, right: 20),
                            child: TextField(
                              controller: messageC,
                              maxLines: null,
                              minLines: 6,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                contentPadding: EdgeInsets.all(18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () => {
                          controller.createReview(messageC.text),
                          controller.done(orderId)
                        },
                        // Get.toNamed(Routes.PAYMENT, arguments: orderId)
                        child: Container(
                          margin: EdgeInsets.only(top: height * 0.025),
                          width: width * 0.82,
                          height: height * 0.07,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 3,
                                    blurRadius: 4,
                                    offset: Offset(0, 4))
                              ],
                              color: Color(0xffF9813A),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Padding(
                              padding: EdgeInsets.only(left: 30, right: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Submit',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                          color: Colors.white)),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 22,
                                  )
                                ],
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      )),
    );
  }
}
