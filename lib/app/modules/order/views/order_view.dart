import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {

  final orderController = Get.put(OrderController());
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: orderController.streamOrder(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active) {
            var data = snapshot.data!.docs;
            var userId = localStorage.read('currentUserId');
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                if ((data[index].data() as Map<String, dynamic>)["userId"] == userId 
                && (data[index].data() as Map<String, dynamic>)["status"] != "Completed"
                ) {
                  return ListTile(
                    title: Text("Booking Type: ${(data[index].data() as Map<String, dynamic>)["bookingType"]}"),
                    subtitle: Text("Status: ${(data[index].data() as Map<String, dynamic>)["status"]}"),
                    onTap: () => Get.toNamed(Routes.ORDER_DETAIL,
                    arguments: data[index].id
                    ),
                  );
                } 
                return new Container(height: 0, width: 0,);
                
              },
            
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
          
      )
    );
  }
}
