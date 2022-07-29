import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/information/views/information_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/explore_service_controller.dart';
import 'grooming_list.dart';
import 'vet_service_list.dart';
import 'hotel_service_list.dart';

class ExploreServiceView extends GetView<ExploreServiceController> {
  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                arguments == 1
                    ? 'Grooming Available'
                    : arguments == 2
                        ? 'Pet Hotel Available'
                        : arguments == 3
                            ? 'Vet Available'
                            : 'Pet Information',
                style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 15),
              ),
              backgroundColor: Color(0xffF9813A),
              elevation: 0,
            ),
            body: arguments == 1
                ? GroomingServiceView()
                : arguments == 2
                    ? HotelServiceView()
                    : arguments == 3
                        ? VetServiceView()
                        : InformationView()));
  }
}
