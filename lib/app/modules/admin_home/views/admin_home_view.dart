import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';
import 'package:halopet_beta/app/modules/admin_list_users/views/admin_list_users_view.dart';
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

  final tabs = [Home(), AdminListUsersView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => tabs[homeController.index.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: homeController.index.value,
          fixedColor: Color(0xFFF33ca7f),
          unselectedItemColor: Color(0xFFF33ca7f),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.done_all_outlined),
                label: "Request",
                backgroundColor: Colors.grey.shade100),
            BottomNavigationBarItem(
                icon: Icon(Icons.admin_panel_settings_rounded),
                label: "Users",
                backgroundColor: Colors.grey.shade100),
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
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Petshop Create Request',
          style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 15),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF33ca7f),
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
                      var dataMap = data[index].data() as Map<String, dynamic>;
                      return Container(
                        height: height * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 0.5, color: Colors.grey.shade300),
                        ),
                        child: Container(
                          height: height * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(children: [
                            Container(
                              width: width * 0.35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Container(
                                height: height * 0.12,
                                width: width * 0.12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/images/petshop-1.jpg')),
                                ),
                              ),
                            ),
                            Container(
                              width: width * 0.64,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, left: 16, bottom: 16, right: 36),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco.Light',
                                          fontSize: 10),
                                    ),
                                    Text(
                                      dataMap['petshopName'],
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco',
                                          fontSize: 13,
                                          color: Colors.grey.shade700),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'Service Available',
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco.Light',
                                          fontSize: 10),
                                    ),
                                    dataMap['vetService'] == true
                                        ? Text(
                                            'Vet Available',
                                            style: TextStyle(
                                                fontFamily: 'SanFrancisco',
                                                fontSize: 13,
                                                color: Colors.grey.shade700),
                                          )
                                        : SizedBox(),
                                    dataMap['groomingService'] == true
                                        ? Text(
                                            'Grooming Service',
                                            style: TextStyle(
                                                fontFamily: 'SanFrancisco',
                                                fontSize: 13,
                                                color: Colors.grey.shade700),
                                          )
                                        : SizedBox(),
                                    dataMap['petHotelService'] == true
                                        ? Text(
                                            'Pet Hotel Services',
                                            style: TextStyle(
                                                fontFamily: 'SanFrancisco',
                                                fontSize: 13,
                                                color: Colors.grey.shade700),
                                          )
                                        : SizedBox(),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ButtonTheme(
                                          minWidth: 35.0,
                                          height: 35.0,
                                          child: RaisedButton(
                                            elevation: 0,
                                            color: Colors.white,
                                            onPressed: () => {
                                              Get.toNamed(
                                                  Routes.ADMIN_PETSHOP_APPROVAL,
                                                  arguments: data[index].id)
                                            },
                                            child: Icon(
                                              Icons.info,
                                              color: Colors.black,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]),
                        ),
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
        backgroundColor: Color(0xFFF33ca7f),
        onPressed: () => authController.logout(),
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}
