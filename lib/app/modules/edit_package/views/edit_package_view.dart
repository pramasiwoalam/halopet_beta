import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/edit_package/views/edit_package_grooming.dart';
import 'package:halopet_beta/app/modules/package_form/views/package_grooming.dart';
import 'package:halopet_beta/app/modules/package_form/views/package_hotel.dart';
import 'package:halopet_beta/app/modules/package_form/views/package_session_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/edit_package_controller.dart';

class EditPackageView extends GetView<EditPackageController> {
  final localStorage = GetStorage();

  var argument = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Package Registration',
            style: TextStyle(
                fontFamily: 'SanFrancisco',
                fontSize: 15,
                color: Colors.grey.shade800),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: argument == 'Grooming'
            ? EditGrooming()
            : argument == 'Hotel'
                ? PackageHotel()
                : PackageSession()
        // argument == 'Hotel'
        // ? HotelService()
        // : argument == 'detailGrooming'
        //     ? DetailGroomingService()
        //     : VetService());
        );
  }
}
