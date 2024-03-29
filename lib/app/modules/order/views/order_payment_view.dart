import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/order_controller.dart';

class PaymentUserContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    final localStorage = GetStorage();
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var userId = localStorage.read('currentUserId');
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot<Object?>>(
              stream: orderController.getByPaymentStatus(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var data = snapshot.data!.docs;
                  if (data.length > 0) {
                    return ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var dataMap =
                            data[index].data() as Map<String, dynamic>;
                        return InkWell(
                          onTap: () => {
                            localStorage.write(
                                'petshopId', data[index]['petshopId']),
                            Get.toNamed(Routes.ORDER_DETAIL,
                                arguments: data[index].id)
                          },
                          child: Container(
                            height: height * 0.17,
                            width: width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade200,
                                ),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.32,
                                    child: Center(
                                      child: Container(
                                          width: width * 0.32,
                                          height: height * 0.18,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Order ID',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontFamily:
                                                          'SanFrancisco')),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                  "#${data[index].id.toUpperCase()}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.orange,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          'SanFrancisco'))
                                            ],
                                          ))),
                                    ),
                                  ),
                                  Container(
                                    height: height * 0.12,
                                    child: VerticalDivider(
                                      thickness: 1.2,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                      width: width * 0.5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: height * 0.025,
                                            width: width * 0.4,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                                child: Text(
                                                    'Waiting for Payment',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontFamily:
                                                            'SanFrancisco.Light'))),
                                          ),
                                          SizedBox(height: 5),
                                          FutureBuilder<
                                                  DocumentSnapshot<Object?>>(
                                              future:
                                                  orderController.getPetshop(
                                                      dataMap['petshopId']),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  var petshopData = snapshot
                                                          .data!
                                                          .data()
                                                      as Map<String, dynamic>;
                                                  return Text(
                                                      petshopData[
                                                          'petshopName'],
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'SanFrancisco'));
                                                } else {
                                                  return Container(
                                                    height: 5,
                                                    width: 5,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                  );
                                                }
                                              }),
                                          Text(dataMap['bookingType'],
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontFamily:
                                                      'SanFrancisco.Light')),
                                          SizedBox(
                                            height: 1,
                                          ),
                                          Divider(
                                            thickness: 1.2,
                                          ),
                                          SizedBox(
                                            height: 1,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Booking Created',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontFamily:
                                                          'SanFrancisco.Light')),
                                              Text(dataMap['orderCreated'],
                                                  style: const TextStyle(
                                                      color: Colors.orange,
                                                      fontSize: 11,
                                                      fontFamily:
                                                          'SanFrancisco'))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Booking Date',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontFamily:
                                                          'SanFrancisco.Light')),
                                              Text(dataMap['orderDate'],
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.orange,
                                                      fontFamily:
                                                          'SanFrancisco'))
                                            ],
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return EmptyContainer();
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 80),
          height: height * 0.2,
          width: width / 2.6,
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('assets/images/thumb.png')),
          ),
        ),
        Container(
          height: height * 0.1,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('There are no payments due.',
                  style: TextStyle(
                      fontFamily: 'SanFrancisco.Light',
                      fontSize: 13,
                      color: Colors.grey.shade800)),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () => {Get.toNamed(Routes.HOMEPAGE)},
                child: Text('Book your appointment here',
                    style: TextStyle(
                        fontFamily: 'SanFrancisco',
                        fontSize: 13,
                        color: Colors.blue)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
