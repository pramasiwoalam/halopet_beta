import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/petshop_list_controller.dart';
import 'get_all_petshop.dart';
import 'get_by_most_favorited.dart';
import 'get_by_most_rated.dart';

class PetshopListView extends GetView<PetshopListController> {
  List<Widget> containerList = [
    GetAllPetshopView(),
    GetByMostFavoritedPetshopView(),
    GetByMostRatedPetshopView(),
    GetAllPetshopView(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'Explore',
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 17),
            ),
            backgroundColor: Color(0xffF9813A),
            elevation: 0,
            bottom: TabBar(
                labelStyle: GoogleFonts.roboto(
                    fontSize: 13, fontWeight: FontWeight.w600),
                isScrollable: true,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: const <Widget>[
                  Tab(
                    text: "All Petshop",
                  ),
                  Tab(
                    text: "Most Favorited",
                  ),
                  Tab(
                    text: "Most Rated",
                  ),
                  Tab(
                    text: "Near You",
                  ),
                ]),
          ),
          body: TabBarView(
            children: containerList,
          )),
    );
  }
}
