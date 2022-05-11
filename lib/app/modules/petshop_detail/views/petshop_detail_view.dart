import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/petshop_detail_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

final localStorage = GetStorage();

class PetshopDetailView extends GetView<PetshopDetailController> {
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

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(-62),
          child: AppBar(
            title: Text(
              'Detail',
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 0),
            ),
            backgroundColor: Colors.black,
            elevation: 0,
          ),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot<Object?>>(
              future: controller.getPetshopDetail(petshopId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  var currentUserId = localStorage.read('currentUserId');
                  print(data['favoriteId']);
                  return Stack(
                    children: <Widget>[
                      Positioned(
                        top: height / 10,
                        child: Container(
                          height: height / 4,
                          width: width,
                          // color: Colors.red,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Container(
                        height: height / 2.8,
                        width: width,
                        child: Image.asset(
                          'assets/images/petshop-1.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: height / 3.05),
                            height: height * 0.022,
                            width: width,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                                color: Color(0xffF9813A)),
                          ),
                          Container(
                            height: height,
                            width: width,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: AppBar(
                                    backgroundColor: Color(0xffF9813A),
                                    elevation: 0,
                                    bottom: TabBar(
                                      labelStyle: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                      indicatorColor: Colors.white,
                                      tabs: const [
                                        Tab(
                                          text: 'Shop Info',
                                        ),
                                        Tab(
                                          text: 'Services',
                                        ),
                                        Tab(
                                          text: 'Reviews',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: TabBarView(
                                    children: [ShopInfo(), Service(), Review()],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: height / 12.7,
                        child: Container(
                          height: height / 4,
                          width: width,
                          // color: Colors.red,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.center,
                                  colors: [
                                Colors.grey.withOpacity(0.0),
                                Colors.black.withOpacity(0.7),
                              ],
                                  stops: const [
                                0.0,
                                10.0
                              ])),
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
                      Positioned(
                        top: height / 4.8,
                        left: 5,
                        child: Container(
                            height: height * 0.15,
                            width: width * 0.70,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${data["petshopName"]}',
                                        style: GoogleFonts.inter(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        'OPEN',
                                        style: GoogleFonts.inter(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.yellow),
                                      ),
                                      Text(
                                        '${data["petshopAddress"]}',
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}

class ShopInfo extends StatelessWidget {
  const ShopInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PetshopDetailController());
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Container(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Information',
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800),
              ),
              Container(
                width: width / 4,
                child: Divider(
                  thickness: 2,
                  color: Colors.grey.shade800,
                ),
              ),
              Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Services',
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800),
              ),
              Container(
                width: width / 4,
                child: Divider(
                  thickness: 2,
                  color: Colors.grey.shade800,
                ),
              ),
              Text('Grooming Services',
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              const SizedBox(
                height: 2,
              ),
              Text('Pet Hotel Services',
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              const SizedBox(
                height: 2,
              ),
              Text('Vet Available',
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Location',
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800),
              ),
              Container(
                width: width / 4,
                child: Divider(
                  thickness: 2,
                  color: Colors.grey.shade800,
                ),
              ),
              Text('Jl. Gang Pori No.99',
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              const SizedBox(
                height: 3,
              ),
              Text('Pisangan, Jakarta Timur',
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Open Days',
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800),
              ),
              Container(
                width: width / 4,
                child: Divider(
                  thickness: 2,
                  color: Colors.grey.shade800,
                ),
              ),
              Text('Monday - Saturday',
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              const SizedBox(
                height: 3,
              ),
              Text('09.00 - 21.00',
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Service extends StatelessWidget {
  const Service({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PetshopDetailController());
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var petshopId = localStorage.read('petshopId');

    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.getServiceByPetshop(petshopId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var data = snapshot.data!.docs;
            return Container(
              height: height,
              width: width * 0.5,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var dataMap = data[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      height: height * 0.15,
                      width: width * 0.7,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(0, 3))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 24, bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => {
                                AwesomeDialog(
                                  context: context,
                                  padding: EdgeInsets.all(20),
                                  dialogType: DialogType.NO_HEADER,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'Confirmation',
                                  desc:
                                      'Are you sure want to create this order?.',
                                  btnCancelOnPress: () => {},
                                  btnCancelColor: Colors.grey.shade200,
                                  btnOkColor: Colors.green.shade200,
                                  btnOkText: 'Yes',
                                  buttonsTextStyle: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade800),
                                  btnOkOnPress: () {
                                    localStorage.write(
                                        'selectedServiceId', data[index].id);
                                    print(
                                        localStorage.read('selectedServiceId'));
                                    Get.toNamed(Routes.CHOOSE_PET);

                                    AwesomeDialog(
                                      padding: EdgeInsets.all(20),
                                      context: context,
                                      dialogType: DialogType.INFO_REVERSED,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Choose your pet.',
                                      desc:
                                          'Choose who will be in service. Make sure you already registered your pet.',
                                      btnOkText: 'Ok',
                                      btnOkColor: Colors.grey.shade300,
                                      buttonsTextStyle: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade800),
                                      btnOkOnPress: () {},
                                    ).show();
                                  },
                                ).show()
                              },
                              child: Container(
                                width: width * 0.65,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 12, top: 8),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              dataMap['serviceName'],
                                              style: GoogleFonts.inter(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey.shade800),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: width * 0.5,
                                          child: const Divider(
                                            thickness: 1,
                                          ),
                                        ),
                                        Text(
                                          'Book your service at this petshop.',
                                          style: GoogleFonts.inter(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey.shade700),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.19,
                              width: width * 0.2,
                              child:
                                  Center(child: Icon(Icons.arrow_forward_ios)),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class Review extends StatelessWidget {
  const Review({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PetshopDetailController());
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var petshopId = localStorage.read('petshopId');

    return Container(
        width: width,
        child: StreamBuilder<QuerySnapshot<Object?>>(
            stream: controller.streamReview(petshopId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var data = snapshot.data!.docs;
                if (data.isNotEmpty) {
                  return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var dataMap =
                            data[index].data() as Map<String, dynamic>;
                        return Container(
                          height: height * 0.2,
                          width: width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.shade200,
                              ),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${dataMap['userName']}',
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'Service: Pet Hotel',
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              color: Colors.grey.shade700),
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 1),
                                      height: 30,
                                      width: 50,
                                      color: Colors.green,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('${dataMap['rating']}',
                                              style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: Colors.white)),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          const Icon(
                                            Icons.star,
                                            size: 13,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  '${dataMap['message']}',
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    Text(
                                        '${timeago.format((dataMap['reviewCreated'] as Timestamp).toDate())}',
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: Text('No reviews yet.'),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
