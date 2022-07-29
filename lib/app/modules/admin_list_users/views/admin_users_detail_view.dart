import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/admin_list_users_controller.dart';

class AdminUserDetailView extends GetView<AdminListUsersController> {
  final listController = Get.put(AdminListUsersController());
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var arguments = Get.arguments;

    double bookingFee = 5000;
    double charge = 0;
    if (localStorage.read('deliveryCharge') == null) {
      charge = bookingFee;
    } else {
      charge = bookingFee + localStorage.read('deliveryCharge');
    }

    localStorage.write('totalCharge', charge);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail',
            style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 15)),
        centerTitle: true,
        backgroundColor: Color(0xFFF33ca7f),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getUser(arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var dataMap = snapshot.data!.data() as Map<String, dynamic>;
                return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.6,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 4))
                            ],
                            border: Border.all(
                                width: 1, color: Colors.grey.shade200),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(26.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.person,
                                      size: 22,
                                      color: Color(0xFFF33ca7f),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    VerticalDivider(
                                      width: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'User Detail',
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco.Light',
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Spacer(),
                                Text(
                                  'Name',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  dataMap['name'],
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco', fontSize: 13),
                                ),
                                Spacer(),
                                Divider(
                                  thickness: 1,
                                ),
                                Spacer(),
                                Text(
                                  'Address',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  dataMap['address'],
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco', fontSize: 13),
                                ),
                                Spacer(),
                                Divider(
                                  thickness: 1,
                                ),
                                Spacer(),
                                Text(
                                  'Phone Number',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  dataMap['phone'],
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco', fontSize: 13),
                                ),
                                Spacer(),
                                Divider(
                                  thickness: 1,
                                ),
                                Spacer(),
                                Text(
                                  'Email',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  dataMap['email'],
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco', fontSize: 13),
                                ),
                                Spacer(),
                                Divider(
                                  thickness: 1,
                                ),
                                Spacer(),
                                Text(
                                  'City',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  dataMap['city'],
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco', fontSize: 13),
                                ),
                                Spacer(),
                                Divider(
                                  thickness: 1,
                                ),
                                Spacer(),
                                Text(
                                  'Postal Code',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  dataMap['postalCode'],
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco', fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
