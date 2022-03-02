import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    List favoriteArr = GetStorage().read('favArr');

    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'Favorites',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 19),
          )),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
        ),
        body: favoriteArr.isNotEmpty
            ? StreamBuilder<QuerySnapshot<Object?>>(
                stream: controller.getPetshopByFavId(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    var data = snapshot.data!.docs;

                    return ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var dataMap =
                              data[index].data() as Map<String, dynamic>;
                          return InkWell(
                            onTap: () => Get.toNamed(Routes.PETSHOP_DETAIL,
                                arguments: data[index].id),
                            child: Container(
                                height: height * 0.2,
                                width: width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade300),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10, left: 6),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8, left: 10),
                                        child: Container(
                                          height: height * 0.18,
                                          width: width * 0.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: const DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/images/petshop-1.jpg')),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 9.0, bottom: 10, left: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 9, bottom: 10),
                                        child: Container(
                                          height: height * 0.2,
                                          width: width * 0.55,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                ' ${dataMap['petshopName']}',
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              ),
                                              const SizedBox(
                                                height: 1,
                                              ),
                                              Text(
                                                ' Jakarta, Indonesia',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 13),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: 19,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text('5.0 (238)',
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.verified_rounded,
                                                    color: Color(0xff3CBA54),
                                                    size: 18,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Grooming, Pet Hotel, Vet',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Container(
                                                height: height * 0.034,
                                                width: width * 0.23,
                                                color: Colors.blue.shade300,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Center(
                                                    child: Text(
                                                      'Most Favorites',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
            : const Center(
                child: Text('Empty'),
              ));
  }
}
