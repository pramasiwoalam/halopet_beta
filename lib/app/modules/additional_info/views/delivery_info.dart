import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/add_petshop/controllers/add_petshop_controller.dart';
import 'package:halopet_beta/app/modules/additional_info/controllers/doctor_registration_controller.dart';
import 'package:halopet_beta/app/modules/edit_service/controllers/edit_service_controller.dart';

class DeliveryInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var userId = localStorage.read('currentUserId');
    final infoController = Get.put(AdditionalInfoController());
    return Container(
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
        border: Border.all(width: 1, color: Colors.grey.shade200),
      ),
      child: FutureBuilder<DocumentSnapshot<Object?>>(
          future: infoController.getUser(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              return Padding(
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
                          Icons.delivery_dining,
                          size: 20,
                          color: Colors.grey.shade800,
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
                          'Delivery Information',
                          style: TextStyle(
                              fontFamily: 'SanFrancisco.Light', fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Spacer(),
                    Text(
                      'Delivery Option',
                      style: TextStyle(
                          fontFamily: 'SanFrancisco.Light', fontSize: 11),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Pick Up & Delivery',
                      style:
                          TextStyle(fontFamily: 'SanFrancisco', fontSize: 13),
                    ),
                    Spacer(),
                    Divider(
                      thickness: 1,
                    ),
                    Spacer(),
                    Text(
                      'Delivery Appointment',
                      style: TextStyle(
                          fontFamily: 'SanFrancisco.Light', fontSize: 11),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '01.00 PM',
                      style:
                          TextStyle(fontFamily: 'SanFrancisco', fontSize: 13),
                    ),
                    Spacer(),
                    Divider(
                      thickness: 1,
                    ),
                    Spacer(),
                    Text(
                      'Address',
                      style: TextStyle(
                          fontFamily: 'SanFrancisco.Light', fontSize: 11),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      data['address'],
                      style:
                          TextStyle(fontFamily: 'SanFrancisco', fontSize: 13),
                    ),
                    Spacer(),
                    Divider(
                      thickness: 1,
                    ),
                    Spacer(),
                    Text(
                      'District',
                      style: TextStyle(
                          fontFamily: 'SanFrancisco.Light', fontSize: 11),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      data['district'] == null ? 'Kramat' : data['district'],
                      style:
                          TextStyle(fontFamily: 'SanFrancisco', fontSize: 13),
                    ),
                    Spacer(),
                    Divider(
                      thickness: 1,
                    ),
                    Spacer(),
                    Text(
                      'City',
                      style: TextStyle(
                          fontFamily: 'SanFrancisco.Light', fontSize: 11),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      data['city'],
                      style:
                          TextStyle(fontFamily: 'SanFrancisco', fontSize: 13),
                    ),
                    Spacer(),
                    Divider(
                      thickness: 1,
                    ),
                    Spacer(),
                    Text(
                      'Postal Code',
                      style: TextStyle(
                          fontFamily: 'SanFrancisco.Light', fontSize: 11),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      data['postalCode'],
                      style:
                          TextStyle(fontFamily: 'SanFrancisco', fontSize: 13),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
