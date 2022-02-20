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
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                              onTap: () => Get.toNamed(Routes.PETSHOP_DETAIL,
                                  arguments: data[index].id),
                              child: Container(
                                // color: Colors.red,
                                height: height * 0.3,
                                width: width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: height * 0.18,
                                        width: width * 0.90,
                                        // color: Colors.blue,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
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
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
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
                                                      fontSize: 18),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(right: 5),
                                                  width: 55,
                                                  height: 30,
                                                  // color: Colors.green,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text('5.0',
                                                          style: GoogleFonts
                                                              .roboto(
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
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 14),
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
                })
            : Center(
                child: Text('Empty'),
              ));
  }
}
