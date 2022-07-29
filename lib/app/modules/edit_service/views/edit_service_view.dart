import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/edit_service/views/edit_service_grooming.dart';
import 'package:halopet_beta/app/modules/package_form/views/package_grooming.dart';
import 'package:halopet_beta/app/modules/service_form/views/service_form_grooming.dart';
import 'package:halopet_beta/app/modules/service_form/views/service_form_hotel.dart';
import 'package:halopet_beta/app/modules/service_form/views/service_form_vet.dart';

import '../controllers/edit_service_controller.dart';
import 'edit_service_hotel.dart';
import 'edit_service_vet.dart';

class EditServiceView extends GetView<EditServiceController> {
  @override
  Widget build(BuildContext context) {
    var argument = Get.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Service',
            style: TextStyle(
                fontFamily: 'SanFrancisco',
                fontSize: 15,
                color: Colors.grey.shade800),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: argument == 'Grooming Service'
            ? EditGroomingService()
            : argument == 'Hotel Service'
                ? EditHotelService()
                : EditVetService());
  }
}
