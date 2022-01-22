import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';
import 'package:halopet_beta/app/modules/admin_list_users/views/admin_list_users_view.dart';
import 'package:halopet_beta/app/modules/history/views/history_view.dart';
import 'package:halopet_beta/app/modules/homepage/views/homepage_view.dart';
import 'package:halopet_beta/app/modules/order/views/order_view.dart';
import 'package:halopet_beta/app/modules/profile/views/profile_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final authController = Get.find<AuthController>();
  final homeController = Get.put(AdminHomeController());

  void indexAction(int index) {
    homeController.index.value = index;
  }

  final tabs = [Home(), AdminListUsersView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => tabs[homeController.index.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: homeController.index.value,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.done_all_outlined),
                title: Text("Request"),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.admin_panel_settings_rounded),
                title: Text("Users"),
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
                backgroundColor: Colors.brown),
          ],
          onTap: (index) {
            indexAction(index);
          },
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final homeController = Get.put(AdminHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Petshop Create Request'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: homeController.streamData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var data = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    if ((data[index].data()
                            as Map<String, dynamic>)['status'] ==
                        'Waiting for Approval') {
                      return ListTile(
                        onTap: () => Get.toNamed(Routes.ADMIN_PETSHOP_APPROVAL,
                            arguments: [
                              {'id': data[index].id},
                              {
                                'ownerId': (data[index].data()
                                    as Map<String, dynamic>)['petshopOwner']
                              }
                            ]),
                        title: Text(
                            "${(data[index].data() as Map<String, dynamic>)["petshopName"]}"),
                        subtitle: Text(
                            "${(data[index].data() as Map<String, dynamic>)["petshopAddress"]}"),
                      );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => authController.logout(),
        child: Icon(Icons.add),
      ),
    );
  }
}
