import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/seller_history_controller.dart';

class SellerHistoryView extends GetView<SellerHistoryController> {
  final localStorage = GetStorage();
  final homeController = Get.put(SellerHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SellerHistoryView'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: controller.streamData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var data = snapshot.data!.docs;
              var petshopId = localStorage.read('initialPetshopId');
              print('petshop id pada home: $petshopId');
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    if ((data[index].data()
                                    as Map<String, dynamic>)['petshopId'] ==
                                petshopId &&
                            (data[index].data()
                                    as Map<String, dynamic>)['status'] ==
                                'Declined' ||
                        (data[index].data()
                                    as Map<String, dynamic>)['petshopId'] ==
                                petshopId &&
                            (data[index].data()
                                    as Map<String, dynamic>)['status'] ==
                                'Done') {
                      return ListTile(
                          onTap: () => Get.toNamed(Routes.SELLER_ORDER_DETAIL,
                              arguments: data[index].id),
                          title: Text(
                              "Booking Type: ${(data[index].data() as Map<String, dynamic>)["bookingType"]}"),
                          subtitle: Text(
                              "Status: ${(data[index].data() as Map<String, dynamic>)["status"]}"));
                    } else {
                      return SizedBox();
                    }
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
