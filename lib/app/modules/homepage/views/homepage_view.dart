import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';
import 'package:halopet_beta/app/modules/add_petshop/views/add_petshop_view.dart';
import 'package:halopet_beta/app/modules/doctor_registration/views/doctor_registration_view.dart';
import 'package:halopet_beta/app/modules/history/views/history_view.dart';
import 'package:halopet_beta/app/modules/order/views/order_view.dart';
import 'package:halopet_beta/app/modules/profile/views/profile_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/homepage_controller.dart';

class HomepageView extends GetView<HomepageController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final authController = Get.find<AuthController>();
  final homeController = Get.put(HomepageController());
  final localStorage = GetStorage();

  void indexAction(int index) {
    homeController.index.value = index;
  }

  final tabs = [Home(), OrderView(), HistoryView(), ProfileView()];

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
                icon: Icon(Icons.home),
                title: Text("Home"),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.book),
                title: Text("Order"),
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.history_edu),
                title: Text("History"),
                backgroundColor: Colors.pink),
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
  final homeController = Get.put(HomepageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
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
                        'Approved') {
                      return ListTile(
                        onTap: () => Get.toNamed(Routes.PETSHOP_DETAIL,
                            arguments: data[index].id),
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
        onPressed: () => Get.toNamed(Routes.ADD_PETSHOP),
        child: Icon(Icons.add),
      ),
    );
  }
}
