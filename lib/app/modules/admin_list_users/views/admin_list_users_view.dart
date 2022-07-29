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
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('User List',
              style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 15)),
          centerTitle: true,
          backgroundColor: Color(0xFFF33ca7f),
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder<QuerySnapshot<Object?>>(
            stream: listController.streamUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var data = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var dataMap = data[index].data() as Map<String, dynamic>;
                    var user = data[index].id.toUpperCase();
                    if ((data[index].data() as Map<String, dynamic>)["role"] !=
                        "Admin") {
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
                                      fit: BoxFit.contain,
                                      image:
                                          AssetImage('assets/images/user.png')),
                                ),
                              ),
                            ),
                            Container(
                              width: width * 0.64,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
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
                                      dataMap['name'],
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco',
                                          fontSize: 13,
                                          color: Colors.grey.shade700),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'Role',
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco.Light',
                                          fontSize: 10),
                                    ),
                                    Text(
                                      dataMap['petshopOwner'] == true
                                          ? 'Member & Petshop Owner'
                                          : 'Member',
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco',
                                          fontSize: 13,
                                          color: Colors.grey.shade700),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco.Light',
                                          fontSize: 10),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      dataMap['email'],
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco',
                                          fontSize: 13,
                                          color: Colors.grey.shade700),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          child: ButtonTheme(
                                            minWidth: 40.0,
                                            height: 40.0,
                                            child: RaisedButton(
                                              elevation: 0,
                                              color: Colors.white,
                                              onPressed: () => {
                                                Get.toNamed(
                                                    Routes.ADMIN_USER_DETAIL,
                                                    arguments: data[index].id)
                                              },
                                              child: Icon(Icons.info,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        ButtonTheme(
                                          minWidth: 40.0,
                                          height: 40.0,
                                          child: RaisedButton(
                                            elevation: 0,
                                            color: Colors.white,
                                            onPressed: () => {
                                              Get.dialog(AlertDialog(
                                                title: Text(
                                                  'Alert',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'SanFrancisco',
                                                      fontSize: 14),
                                                ),
                                                titlePadding: EdgeInsets.only(
                                                    left: 26,
                                                    right: 26,
                                                    top: 30),
                                                contentPadding: EdgeInsets.only(
                                                    left: 26,
                                                    right: 26,
                                                    top: 16,
                                                    bottom: 12),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                content: Text(
                                                    'Are you sure want to delete this user?',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'SanFrancisco.Light',
                                                        fontSize: 12)),
                                                actionsPadding: EdgeInsets.only(
                                                    right: 12,
                                                    top: 6,
                                                    bottom: 2),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () =>
                                                          {Get.back()},
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'SanFrancisco.Light',
                                                            fontSize: 13,
                                                            color: Color(
                                                                0xFFF33ca7f)),
                                                      )),
                                                  TextButton(
                                                      onPressed: () => {
                                                            Get.back(),
                                                            controller
                                                                .deleteUser(
                                                                    data[index]
                                                                        .id),
                                                            Get.dialog(
                                                                AlertDialog(
                                                              title: Text(
                                                                'Delete Succesful',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'SanFrancisco',
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                              titlePadding:
                                                                  EdgeInsets.only(
                                                                      left: 26,
                                                                      right: 26,
                                                                      top: 30),
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      left: 26,
                                                                      right: 26,
                                                                      top: 16,
                                                                      bottom:
                                                                          12),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              content: Text(
                                                                  'Delete request succesfully.',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'SanFrancisco.Light',
                                                                      fontSize:
                                                                          12)),
                                                              actionsPadding:
                                                                  EdgeInsets.only(
                                                                      right: 12,
                                                                      top: 6,
                                                                      bottom:
                                                                          2),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () => {
                                                                              Get.back()
                                                                            },
                                                                    child: Text(
                                                                      'Ok',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'SanFrancisco',
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              Color(0xFFF33ca7f)),
                                                                    )),
                                                              ],
                                                            ))
                                                          },
                                                      child: Text(
                                                        'Yes',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'SanFrancisco',
                                                            fontSize: 13,
                                                            color: Color(
                                                                0xFFF33ca7f)),
                                                      )),
                                                ],
                                              ))
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ]),
                        ),
                      );
                    }
                    return new Container(
                      height: 0,
                      width: 0,
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
