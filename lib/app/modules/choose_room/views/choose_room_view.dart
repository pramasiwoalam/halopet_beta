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

import '../../grooming_order/controllers/grooming_order_controller.dart';
import '../../order/controllers/order_controller.dart';
import '../controllers/choose_room_controller.dart';

class ChooseRoomView extends GetView<ChooseRoomController> {
  final messageC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(GroomingOrderController());
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    var serviceId = localStorage.read('selectedServiceId');
    print(serviceId);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Choose Room Session',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 17),
        ),
        backgroundColor: Color(0xffF9813A),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.getRoom(serviceId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var roomData = snapshot.data!.docs;

            return Column(
              children: [
                ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: roomData.length,
                    itemBuilder: (context, index) {
                      var dataMap =
                          roomData[index].data() as Map<String, dynamic>;
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 5, right: 5),
                        child: InkWell(
                          onTap: () => {
                            Get.dialog(AlertDialog(
                              title: const Text(
                                'Delivey Option',
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
                              actionsPadding:
                                  EdgeInsets.only(top: 6, bottom: 2),
                              actions: [
                                TextButton(
                                    onPressed: () => {
                                          Get.back(),
                                          localStorage.write('roomName',
                                              roomData[index]['name']),
                                          localStorage.write(
                                              'roomId', roomData[index].id),
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
                                          localStorage.write('roomName',
                                              roomData[index]['name']),
                                          localStorage.write(
                                              'roomId', roomData[index].id),
                                          Get.toNamed(Routes.CREATE_ORDER,
                                              arguments: "Hotel")
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
                            height: height * 0.18,
                            width: width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade200,
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: Offset(0, 4))
                                ],
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    width: width * 0.32,
                                    height: height,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: const DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              'assets/images/pet-hotel.jpg')),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: width * 0.55,
                                    height: height,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Text(
                                          dataMap['name'],
                                          style: TextStyle(
                                              fontFamily: 'SanFrancisco',
                                              fontSize: 14),
                                        ),
                                        Spacer(),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vehicula vestibulum faucibus.',
                                          style: TextStyle(
                                              fontFamily: 'SanFrancisco.Light',
                                              fontSize: 12),
                                        ),
                                        Spacer(),
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.pets,
                                              size: 13,
                                              color: Colors.orange,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Dog, Cat',
                                              style: TextStyle(
                                                  fontFamily:
                                                      'SanFrancisco.Light',
                                                  fontSize: 11),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.price_change,
                                              size: 13,
                                              color: Colors.orange,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Rp. ${dataMap['price']}',
                                              style: TextStyle(
                                                  fontFamily: 'SanFrancisco',
                                                  fontSize: 13),
                                            ),
                                            Text(
                                              ' / night',
                                              style: TextStyle(
                                                  fontFamily:
                                                      'SanFrancisco.Light',
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
              ],
            );
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
