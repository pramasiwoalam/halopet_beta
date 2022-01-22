import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/admin_list_users_controller.dart';

class AdminListUsersView extends GetView<AdminListUsersController> {
  final listController = Get.put(AdminListUsersController());
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        centerTitle: true,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: listController.streamOrder(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active) {
            var data = snapshot.data!.docs;
            var userId = localStorage.read('currentUserId');
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                if ((data[index].data() as Map<String, dynamic>)["role"] != "Admin"
                ) {
                  return ListTile(
                    title: Text("User Id: ${(data[index].data() as Map<String, dynamic>)["userId"]}"),
                    subtitle: Text("Role: ${(data[index].data() as Map<String, dynamic>)["role"]}"),
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
