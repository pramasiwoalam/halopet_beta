import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  final orderController = Get.put(OrderController());
  final localStorage = GetStorage();

  List<Widget> containerList = [
    ApprovalContainer(),
    PaymentContainer(),
    OnGoing(),
    Completed(),
    Cancellation()
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Center(
                child: Text(
              'Your Booking',
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 17),
            )),
            backgroundColor: Color(0xffF9813A),
            elevation: 0,
            bottom: TabBar(
                labelStyle: GoogleFonts.roboto(
                    fontSize: 13, fontWeight: FontWeight.w600),
                isScrollable: true,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: const <Widget>[
                  Tab(
                    text: "Waiting for Approval",
                  ),
                  Tab(
                    text: "Waiting for Payment",
                  ),
                  Tab(
                    text: "On Going",
                  ),
                  Tab(
                    text: "Completed",
                  ),
                  Tab(
                    text: "Cancelled",
                  )
                ]),
          ),
          body: TabBarView(
            children: containerList,
          )),
    );
  }
}

class ApprovalContainer extends StatelessWidget {
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
              stream: orderController.getByApprovalStatus(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var data = snapshot.data!.docs;
                  if (data.length > 0) {
                    return Container(
                      child: ListView.builder(
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
                              height: height * 0.2,
                              width: width,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.shade200,
                                  ),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
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
                                                        fontSize: 14,
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
                                                        fontSize: 16,
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
                                              height: height * 0.026,
                                              width: width * 0.4,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Center(
                                                  child: Text(
                                                      'Waiting for Approval',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11,
                                                          fontFamily:
                                                              'SanFrancisco.Regular'))),
                                            ),
                                            Spacer(),
                                            const Text('Dita Gendut Petshop',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily:
                                                        'SanFrancisco')),
                                            Spacer(),
                                            const Text('Grooming Service',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                        'SanFrancisco.Regular')),
                                            Spacer(),
                                            Divider(
                                              thickness: 1.2,
                                            ),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('Booking Date',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily:
                                                            'SanFrancisco.Regular')),
                                                Text(dataMap['orderDate'],
                                                    style: const TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 13,
                                                        fontFamily:
                                                            'SanFrancisco'))
                                              ],
                                            ),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('Booking Time',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily:
                                                            'SanFrancisco.Regular')),
                                                Text(dataMap['time'],
                                                    style: const TextStyle(
                                                        fontSize: 13,
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
                      ),
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

class PaymentContainer extends StatelessWidget {
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
                        return Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: InkWell(
                            onTap: () => Get.toNamed(Routes.ORDER_DETAIL,
                                arguments: data[index].id),
                            child: Container(
                              height: height * 0.22,
                              width: width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 2,
                                      color: const Color(0xfff0f0f0))),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.timer,
                                            color: Colors.brown),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text('${dataMap['status']}',
                                            style: GoogleFonts.roboto(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.brown))
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 0.5,
                                      height: 25,
                                      color: Color.fromARGB(255, 209, 209, 209),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.date_range,
                                              color: Color(0xffF9813A),
                                            ),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            Text('Order ID',
                                                style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                        Text(
                                          data[index].id,
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.timelapse_sharp,
                                              color: Color(0xffF9813A),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Order Date',
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          data[index]['orderDate'],
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
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

class OnGoing extends StatelessWidget {
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
              stream: orderController.getByOnGoing(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var data = snapshot.data!.docs;
                  if (data.isNotEmpty) {
                    return ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var dataMap =
                            data[index].data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Container(
                            height: height * 0.22,
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 2, color: const Color(0xfff0f0f0))),
                            child: InkWell(
                              onTap: () => {
                                Get.toNamed(Routes.ORDER_DETAIL,
                                    arguments: data[index].id)
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.timer,
                                            color: Colors.brown),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text('${dataMap['status']}',
                                            style: GoogleFonts.roboto(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.brown))
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 0.5,
                                      height: 25,
                                      color: Color.fromARGB(255, 209, 209, 209),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.date_range,
                                              color: Color(0xffF9813A),
                                            ),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            Text('Order ID',
                                                style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                        Text(
                                          data[index].id,
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.timelapse_sharp,
                                              color: Color(0xffF9813A),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Order Date',
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          data[index]['orderDate'],
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
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

class Completed extends StatelessWidget {
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
              stream: orderController.getByCompleted(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var data = snapshot.data!.docs;
                  if (data.isNotEmpty) {
                    return ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var dataMap =
                            data[index].data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Container(
                            height: height * 0.22,
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 2, color: const Color(0xfff0f0f0))),
                            child: InkWell(
                              onTap: () => {
                                Get.toNamed(Routes.ORDER_DETAIL,
                                    arguments: data[index].id)
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.timer,
                                            color: Colors.brown),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text('${dataMap['status']}',
                                            style: GoogleFonts.roboto(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.brown))
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 0.5,
                                      height: 25,
                                      color: Color.fromARGB(255, 209, 209, 209),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.date_range,
                                              color: Color(0xffF9813A),
                                            ),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            Text('Order ID',
                                                style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                        Text(
                                          data[index].id,
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.timelapse_sharp,
                                              color: Color(0xffF9813A),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Order Date',
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          data[index]['orderDate'],
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
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

class Cancellation extends StatelessWidget {
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
              stream: orderController.getByCancellation(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var data = snapshot.data!.docs;
                  if (data.isNotEmpty) {
                    return Container(
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var dataMap =
                              data[index].data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: InkWell(
                              onTap: () => {
                                localStorage.write(
                                    'petshopId', data[index]['petshopId']),
                                Get.toNamed(Routes.ORDER_DETAIL,
                                    arguments: data[index].id)
                              },
                              child: Container(
                                height: height * 0.22,
                                width: width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2,
                                        color: const Color(0xfff0f0f0))),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.timer,
                                              color: Colors.brown),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Text('${dataMap['status']}',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.brown))
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 0.5,
                                        height: 25,
                                        color:
                                            Color.fromARGB(255, 209, 209, 209),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.date_range,
                                                color: Color(0xffF9813A),
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              Text('Order ID',
                                                  style: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                          Text(
                                            data[index].id,
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.timelapse_sharp,
                                                color: Color(0xffF9813A),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Order Date',
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            data[index]['orderDate'],
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
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
              Text(
                'There are no payments due.',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500),
              ),
              const SizedBox(
                height: 7,
              ),
              InkWell(
                onTap: () => {Get.toNamed(Routes.HOMEPAGE)},
                child: Text(
                  'Book your appointment here',
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
