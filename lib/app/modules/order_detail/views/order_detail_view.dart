import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/order_detail_controller.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    dynamic arguments = Get.arguments;
    var status = arguments[1]['status'];
    var petshopId = GetStorage().read('petshopId');
    print(petshopId);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Order Detail',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 19),
        )),
        backgroundColor: Color(0xffF9813A),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () => Get.back(), child: Icon(Icons.arrow_back_rounded)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: Icon(Icons.info),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(7),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              height: height * 0.2,
              width: width,
              child: FutureBuilder<DocumentSnapshot<Object?>>(
                  future: controller.getOrder(arguments[0]['id']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var data = snapshot.data!.data() as Map<String, dynamic>;
                      var currentUserId = localStorage.read('currentUserId');
                      var orderId = arguments[0]['id'];
                      return Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  color: Colors.orange,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  'Order Details',
                                  style: GoogleFonts.roboto(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Order ID'),
                                Text(orderId),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Booking Type'),
                                Text(data['bookingType']),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Status'),
                                Text('Waiting for approval'),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Order Created'),
                                Text('29-09-2022'),
                              ],
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            Container(
              width: width * 0.9,
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 2,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: height * 0.3,
              child: FutureBuilder<DocumentSnapshot<Object?>>(
                  future: controller.getPetshopByOrder(petshopId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var data = snapshot.data!.data() as Map<String, dynamic>;
                      var currentUserId = localStorage.read('currentUserId');
                      var orderId = arguments[0]['id'];
                      var dataMap = data as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  color: Colors.orange,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  'Petshop Detail',
                                  style: GoogleFonts.roboto(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Petshop Name'),
                                Text(dataMap['petshopName']),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Petshop Address'),
                                Text(dataMap['petshopAddress']),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Status'),
                                Text('Waiting for approval'),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Order Created'),
                                Text('29-09-2022'),
                              ],
                            )
                          ],
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            status == 'Waiting for approval'
                ? Container(
                    margin: EdgeInsets.only(top: 5),
                    height: height * 0.3,
                    color: Colors.red,
                    child: Center(child: Text('Box Action')),
                  )
                : status == 'Waiting for payment'
                    ? Container(
                        margin: EdgeInsets.only(top: 5),
                        height: height * 0.3,
                        child: Center(child: Text('Box Action')),
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 5),
                        height: height * 0.3,
                        child: Center(child: Text('Box Action')),
                      )
          ],
        ),
      ),
    );
  }
}
