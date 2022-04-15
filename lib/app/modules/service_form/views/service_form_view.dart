import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/package_form/views/package_grooming.dart';
import 'package:halopet_beta/app/modules/service_form/views/service_form_grooming.dart';
import 'package:halopet_beta/app/modules/service_form/views/service_form_hotel.dart';
import 'package:halopet_beta/app/modules/service_form/views/service_form_vet.dart';

import '../controllers/service_form_controller.dart';

class ServiceFormView extends GetView<ServiceFormController> {
  @override
  Widget build(BuildContext context) {
    var argument = Get.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Service Registration',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
        ),
        body: argument == 'Grooming'
            ? GroomingService()
            : argument == 'Hotel'
                ? HotelService()
                : VetService());
  }
}