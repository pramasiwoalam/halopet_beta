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
    print(status);
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
              height: height * 0.1,
              width: width,
              color: Colors.blue,
              child: Center(child: Text('BOX STATUS')),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: height * 0.47,
              color: Colors.red,
              child: FutureBuilder<DocumentSnapshot<Object?>>(
                  future: controller.getOrder(arguments[0]['id']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var data = snapshot.data!.data() as Map<String, dynamic>;
                      var currentUserId = localStorage.read('currentUserId');
                      var orderId = arguments[0]['id'];
                      localStorage.write('petshopId', arguments[0]['id']);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              'Box Order Detail',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Welcome ${currentUserId}',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Your Order ID: $orderId',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
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
