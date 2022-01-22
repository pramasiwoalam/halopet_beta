import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/seller_order_detail_controller.dart';

class SellerOrderDetailView extends GetView<SellerOrderDetailController> {
  final localStorage = GetStorage();
  final messageC = TextEditingController();
  RxBool isDeclined = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Seller Order Detail'),
          centerTitle: true,
        ),
        body: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getOrder(Get.arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                if (data['status'] == 'Waiting for approval') {
                  return WaitingApproval();
                } else if (data['status'] == 'Booking Created') {
                  return BookCreated();
                } else if (data['status'] == 'Declined') {
                  return Declined();
                } else if (data['status'] == 'Completed') {
                  return Declined();
                } else {
                  return SizedBox();
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}

class WaitingApproval extends GetView<SellerOrderDetailController> {
  final localStorage = GetStorage();
  final messageC = TextEditingController();
  RxBool isDeclined = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getOrder(Get.arguments),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              var currentUserId = localStorage.read('currentUserId');
              var orderId = Get.arguments;
              localStorage.write('petshopId', Get.arguments);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Welcome ${currentUserId}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Your Order ID: TR$orderId',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Pet Type: ${data['petType']}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Do you accept this order?',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () => controller.accepted(orderId),
                          child: Text('Accept')),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Cancellation Reason'),
                                      content: TextField(
                                        onChanged: (value) {},
                                        controller: messageC,
                                        decoration: InputDecoration(
                                            hintText:
                                                "Write your cancellation message..."),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                            child: Text('Cancel'),
                                            onPressed: () => Get.back()),
                                        ElevatedButton(
                                          child: Text('Submit'),
                                          onPressed: () => controller.declined(
                                              orderId, messageC.text),
                                        ),
                                      ],
                                    ));
                          },
                          child: Text('Decline'))
                    ],
                  ),
                  Obx(() => controller.isDeclined == true.obs
                      ? TextField(
                          controller: messageC,
                          decoration: InputDecoration(
                              labelText: 'Cancellation Message ...'),
                        )
                      : SizedBox())
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class BookCreated extends GetView<SellerOrderDetailController> {
  final localStorage = GetStorage();
  final messageC = TextEditingController();
  RxBool isDeclined = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getOrder(Get.arguments),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              var currentUserId = localStorage.read('currentUserId');
              var orderId = Get.arguments;
              localStorage.write('petshopId', Get.arguments);
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Welcome ${currentUserId}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Your Order ID: TR$orderId',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ]);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class Declined extends GetView<SellerOrderDetailController> {
  final localStorage = GetStorage();
  final messageC = TextEditingController();
  RxBool isDeclined = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getOrder(Get.arguments),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              var currentUserId = localStorage.read('currentUserId');
              var orderId = Get.arguments;
              localStorage.write('petshopId', Get.arguments);
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Your Order Has Been Declined',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Cancellation Reason: ${data['message']}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ]);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
