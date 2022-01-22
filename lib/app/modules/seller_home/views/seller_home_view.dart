import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';
import 'package:halopet_beta/app/modules/profile/views/profile_view.dart';
import 'package:halopet_beta/app/modules/seller_history/controllers/seller_history_controller.dart';
import 'package:halopet_beta/app/modules/seller_history/views/seller_history_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/seller_home_controller.dart';

class SellerHomeView extends GetView<SellerHomeController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final authController = Get.find<AuthController>();
  final homeController = Get.put(SellerHomeController());

  void indexAction(int index) {
    homeController.index.value = index;
  }

  final tabs = [Home(), SellerHistoryView(), ProfileView()];

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
                icon: Icon(Icons.history),
                title: Text("History"),
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
  final homeController = Get.put(SellerHomeController());
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Inbox'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: homeController.streamData(),
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
                                as Map<String, dynamic>)['status'] !=
                            'Declined' &&
                        (data[index].data()
                                as Map<String, dynamic>)['status'] !=
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_PETSHOP),
        child: Icon(Icons.add),
      ),
    );
  }
}
