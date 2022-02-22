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
    approvalContainer(),
    payment(),
    onGoing(),
    completed(),
    cancellation()
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
              'Your Order',
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 19),
            )),
            backgroundColor: Color(0xffF9813A),
            elevation: 0,
            bottom: const TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: <Widget>[
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

class approvalContainer extends StatefulWidget {
  @override
  _approvalContainerState createState() => _approvalContainerState();
}

class _approvalContainerState extends State<approvalContainer> {
  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    final localStorage = GetStorage();
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot<Object?>>(
              stream: orderController.getByApprovalStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var data = snapshot.data!.docs;
                  return ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var dataMap = data[index].data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Container(
                          height: height * 0.22,
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2, color: const Color(0xfff0f0f0))),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      child: Container(
                                        height: height * 0.04,
                                        width: width * 0.3,
                                        decoration: BoxDecoration(
                                            color: Color(0xff2596BE),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text('See Detail',
                                                style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white))),
                                      ),
                                      onTap: () => Get.toNamed(
                                          Routes.ORDER_DETAIL,
                                          arguments: [
                                            {'id': data[index].id},
                                            {'status': (dataMap['status'])}
                                          ]),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}

class payment extends StatefulWidget {
  @override
  _paymentState createState() => _paymentState();
}

class _paymentState extends State<payment> {
  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    final localStorage = GetStorage();
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot<Object?>>(
              stream: orderController.getByPaymentStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var data = snapshot.data!.docs;
                  return ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var dataMap = data[index].data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Container(
                          height: height * 0.22,
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2, color: const Color(0xfff0f0f0))),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      child: Container(
                                        height: height * 0.04,
                                        width: width * 0.3,
                                        decoration: BoxDecoration(
                                            color: Color(0xff2596BE),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text('See Detail',
                                                style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white))),
                                      ),
                                      onTap: () => Get.toNamed(
                                          Routes.ORDER_DETAIL,
                                          arguments: [
                                            {'id': data[index].id},
                                            {'status': (dataMap['status'])}
                                          ]),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}

class onGoing extends StatefulWidget {
  @override
  _onGoingState createState() => _onGoingState();
}

class _onGoingState extends State<onGoing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }
}

class completed extends StatefulWidget {
  @override
  _completedState createState() => _completedState();
}

class _completedState extends State<completed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
    );
  }
}

class cancellation extends StatefulWidget {
  @override
  _cancellationState createState() => _cancellationState();
}

class _cancellationState extends State<cancellation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }
}
