import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/petshop_detail_controller.dart';

class PetshopDetailView extends GetView<PetshopDetailController> {
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Petshop Detail'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getPetshopDetail(Get.arguments),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              var currentUserId = localStorage.read('currentUserId');
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
                      'Welcome to ${data["petshopName"]}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  data["groomingService"] == true
                      ? ElevatedButton(
                          onPressed: () => Get.toNamed(Routes.CREATE_ORDER,
                              arguments: snapshot.data!.id),
                          child: Text("Book Grooming Service  >"))
                      : SizedBox(
                          height: 1,
                        ),
                  data["petHotelService"] == true
                      ? ElevatedButton(
                          onPressed: () => Get.toNamed(Routes.PET_HOTEL_ORDER,
                              arguments: snapshot.data!.id),
                          child: Text("Book Pet Hotel Room  >"))
                      : SizedBox(
                          height: 1,
                        )
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
