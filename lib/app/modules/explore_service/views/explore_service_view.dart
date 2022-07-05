import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/explore_service_controller.dart';
import 'grooming_list.dart';
import 'vet_service_list.dart';
import 'hotel_service_list.dart';

class ExploreServiceView extends GetView<ExploreServiceController> {
  List<Widget> containerList = [
    GroomingServiceView(),
    VetServiceView(),
    HotelServiceView(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'Explore by Categories',
              style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 15),
            ),
            backgroundColor: Color(0xffF9813A),
            elevation: 0,
            bottom: TabBar(
                labelStyle: TextStyle(
                  fontFamily: 'SanFrancisco',
                  fontSize: 13,
                ),
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: const <Widget>[
                  Tab(
                    text: "Grooming",
                  ),
                  Tab(
                    text: "Vet Available",
                  ),
                  Tab(
                    text: "Pet Hotel",
                  ),
                ]),
          ),
          body: TabBarView(
            children: containerList,
          )),
    );
  }
}
