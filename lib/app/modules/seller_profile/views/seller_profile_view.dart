import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/seller_profile_controller.dart';

class SellerProfileView extends GetView<SellerProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SellerProfileView'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
        ));
  }
}
