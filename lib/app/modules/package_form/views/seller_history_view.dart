import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/seller_history_controller.dart';

class SellerHistoryView extends GetView<SellerHistoryController> {
  final localStorage = GetStorage();
  final homeController = Get.put(SellerHistoryController());
  var argument = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Package Registration'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Container());
    // argument == 'Grooming'
    //     ? GroomingService()
    //     : argument == 'Hotel'
    //         ? HotelService()
    //         : argument == 'detailGrooming'
    //             ? DetailGroomingService()
    //             : VetService());
  }
}
