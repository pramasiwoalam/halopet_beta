import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/admin_petshop_approval_controller.dart';

class AdminPetshopApprovalView extends GetView<AdminPetshopApprovalController> {
  final localStorage = GetStorage();
  dynamic arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Petshop Approval'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getPetshop(arguments[0]['id']),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              var currentUserId = localStorage.read('currentUserId');
              var petshopId = arguments[0]['id'];
              var petshopOwner = arguments[1]['ownerId'];
              print('pettt: ${petshopId}');
              localStorage.write('petshopId', Get.arguments);
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Petshop Name ${data['petshopName']}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Your Order ID: TR$petshopId',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () =>
                                  controller.accept(petshopId, petshopOwner),
                              child: Text('Accept')),
                          SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () {}, child: Text('Decline'))
                        ],
                      ),
                    )
                  ]);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
