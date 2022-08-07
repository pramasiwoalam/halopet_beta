import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/additional_info/controllers/doctor_registration_controller.dart';
import 'package:halopet_beta/app/modules/edit_service/controllers/edit_service_controller.dart';

class PetInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var petId = localStorage.read('petInfoId');
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
          future: infoController.getPet(petId),
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
                          Icons.pets,
                          size: 16,
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
                          'Pet Information',
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
                      'Pet ID',
                      style: TextStyle(
                          fontFamily: 'SanFrancisco.Light', fontSize: 11),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '#${petId.toString().toUpperCase()}',
                      style:
                          TextStyle(fontFamily: 'SanFrancisco', fontSize: 13),
                    ),
                    Spacer(),
                    Divider(
                      thickness: 1,
                    ),
                    Spacer(),
                    Text(
                      'Pet Name',
                      style: TextStyle(
                          fontFamily: 'SanFrancisco.Light', fontSize: 11),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      data['name'],
                      style:
                          TextStyle(fontFamily: 'SanFrancisco', fontSize: 13),
                    ),
                    Spacer(),
                    Divider(
                      thickness: 1,
                    ),
                    Spacer(),
                    Text(
                      'Species',
                      style: TextStyle(
                          fontFamily: 'SanFrancisco.Light', fontSize: 11),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      data['species'],
                      style:
                          TextStyle(fontFamily: 'SanFrancisco', fontSize: 13),
                    ),
                    Spacer(),
                    Divider(
                      thickness: 1,
                    ),
                    Spacer(),
                    Text(
                      'Weight',
                      style: TextStyle(
                          fontFamily: 'SanFrancisco.Light', fontSize: 11),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      data['weight'],
                      style:
                          TextStyle(fontFamily: 'SanFrancisco', fontSize: 13),
                    ),
                    Spacer(),
                    Divider(
                      thickness: 1,
                    ),
                    Spacer(),
                    Text(
                      'Age',
                      style: TextStyle(
                          fontFamily: 'SanFrancisco.Light', fontSize: 11),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      data['age'],
                      style:
                          TextStyle(fontFamily: 'SanFrancisco', fontSize: 13),
                    ),
                    Spacer(),
                    Divider(
                      thickness: 1,
                    ),
                    Spacer(),
                    Text(
                      'Gender',
                      style: TextStyle(
                          fontFamily: 'SanFrancisco.Light', fontSize: 11),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      data['gender'],
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
