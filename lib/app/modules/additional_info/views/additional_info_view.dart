import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/modules/add_petshop/controllers/add_petshop_controller.dart';
import 'package:halopet_beta/app/modules/additional_info/views/delivery_info.dart';
import 'package:halopet_beta/app/modules/additional_info/views/pet_info.dart';

class AdditionalInfoView extends GetView<AddPetshopController> {
  final dName = TextEditingController();
  final dDescription = TextEditingController();
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Additional Info',
            style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 15),
          ),
          backgroundColor: Color(0xff2596BE),
          elevation: 0,
        ),
        body: arguments == 1 ? DeliveryInfo() : PetInfo());
  }
}
