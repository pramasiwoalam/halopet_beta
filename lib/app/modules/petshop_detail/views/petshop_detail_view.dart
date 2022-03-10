import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/petshop_detail_controller.dart';

class PetshopDetailView extends GetView<PetshopDetailController> {
  final localStorage = GetStorage();

  List<Widget> containerList = [
    ShopInfo(),
    Service(),
    Review(),
  ];

  var tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var petshopId = localStorage.read('petshopId');
    var userId = localStorage.read('currentUserId');
    // print('val :${controller.isFav}');
    // var orderList = controller.orderList;
    // if (orderList.length > 0) {
    //   print('data: ${orderList[0]['serviceName']}');
    // }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getPetshopDetail(petshopId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                var currentUserId = localStorage.read('currentUserId');
                // localStorage.write('petshopId', Get.arguments);
                return Stack(
                  children: [
                    Container(
                      height: height / 2.8,
                      width: width,
                      color: Colors.black,
                      child: Image.asset(
                        'assets/images/petshop-1.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height / 3.05),
                      height: height,
                      width: width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25, bottom: 12, left: 25, right: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data["petshopName"]}',
                              style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffF9813A)),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_pin, size: 18),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${data["petshopAddress"]}',
                                  style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w300, fontSize: 14),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 24,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Day Open',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Color(0xff2596BE)),
                                    ),
                                    Text('Mon-Sat',
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11))
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Icon(
                                  Icons.timer,
                                  size: 25,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Open Hours',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Color(0xff2596BE)),
                                    ),
                                    Text('09.00 - 21.00',
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11))
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1.5,
                              height: 30,
                            ),
                            Text(
                              'Book a service:',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () => Get.toNamed(Routes.CREATE_ORDER,
                                      arguments: snapshot.data!.id),
                                  child: Container(
                                      height: height * 0.14,
                                      width: width * 0.27,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: 2,
                                              color: const Color(0xFFf2f2f2)),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/tag-vet.jpg'),
                                              fit: BoxFit.cover))),
                                ),
                                InkWell(
                                  onTap: () => Get.toNamed(
                                    Routes.CREATE_ORDER,
                                    // arguments: snapshot.data!.id
                                  ),
                                  child: Container(
                                      height: height * 0.14,
                                      width: width * 0.27,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: 2,
                                              color: const Color(0xFFf2f2f2)),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/tag-grooming.jpg'),
                                              fit: BoxFit.cover))),
                                ),
                                InkWell(
                                  onTap: () => Get.toNamed(
                                      Routes.PET_HOTEL_ORDER,
                                      arguments: snapshot.data!.id),
                                  child: Container(
                                      height: height * 0.14,
                                      width: width * 0.27,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: 2,
                                              color: const Color(0xFFf2f2f2)),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/tag-hotel.jpg'),
                                              fit: BoxFit.cover))),
                                )
                              ],
                            ),
                            const Divider(
                              thickness: 1.5,
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Review',
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text('See All',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue)),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                                height: height * 0.14,
                                width: width,
                                // color: Colors.black,
                                child: StreamBuilder<QuerySnapshot<Object?>>(
                                    stream: controller.streamReview(petshopId),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.active) {
                                        var data = snapshot.data!.docs;

                                        return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                              var dataMap = data[index].data()
                                                  as Map<String, dynamic>;
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(right: 8),
                                                  height: height * 0.14,
                                                  width: width * 0.5,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: const Color(
                                                              0xFFf2f2f2))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Prama Ganteng',
                                                              style: GoogleFonts.inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 16),
                                                            ),
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 1),
                                                              height: 24,
                                                              width: 45,
                                                              color:
                                                                  Colors.green,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text('4.5',
                                                                      style: GoogleFonts.inter(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.white)),
                                                                  const SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  const Icon(
                                                                    Icons.star,
                                                                    size: 13,
                                                                    color: Colors
                                                                        .white,
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        const Text(
                                                            'Asik banget servicenya, bikin Geter!')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }))
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: height / 3.6,
                      right: 40,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: height * 0.08,
                          width: height * 0.08,
                          // color: Colors.red,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: const Color(0xFFf2f2f2)),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                          child: StreamBuilder<QuerySnapshot<Object?>>(
                              stream: controller.getFavByPetshopId(
                                  petshopId, userId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  var favData = snapshot.data!.docs;
                                  bool favStatus = false;
                                  if (favData.isNotEmpty) {
                                    favStatus = favData[0]['isFav'];
                                  }
                                  return InkWell(
                                    child: FavoriteButton(
                                      isFavorite: favStatus ? true : false,
                                      valueChanged: (isFavorite) {
                                        controller.createFavorite(isFavorite);
                                      },
                                      iconSize: 50,
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

class ShopInfo extends StatelessWidget {
  const ShopInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Text('shop info'),
    );
  }
}

class Service extends StatelessWidget {
  const Service({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Review extends StatelessWidget {
  const Review({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
