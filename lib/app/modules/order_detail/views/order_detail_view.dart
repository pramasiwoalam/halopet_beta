import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/order_detail_controller.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Petshop Detail'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getOrder(Get.arguments),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            var currentUserId = localStorage.read('currentUserId');
            var orderId = Get.arguments;
            localStorage.write('petshopId', Get.arguments);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('Welcome ${currentUserId}',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Center(
                  child: Text('Your Order ID: TR$orderId',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator());
          }
          
        }
      ),
    );
  }

}
