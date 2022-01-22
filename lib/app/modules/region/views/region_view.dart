import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/region_controller.dart';

class RegionView extends GetView<RegionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RegionView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RegionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
