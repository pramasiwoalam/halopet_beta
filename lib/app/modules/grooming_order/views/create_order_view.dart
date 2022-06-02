import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/grooming_order/views/grooming_order_view.dart';
import 'package:halopet_beta/app/modules/grooming_order/views/vet_order_view.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../delivery_list/controllers/delivery_list_controller.dart';
import '../controllers/grooming_order_controller.dart';

class CreateOrderView extends GetView<GroomingOrderController> {
  final orderController = Get.put(GroomingOrderController());
  final typeController = TextEditingController();
  final deliveryController = Get.put(DeliveryListController());

  void setValue(DateTime dateTime) {
    var date = DateFormat('MMMM dd, yyyy').format(dateTime);
    orderController.date.value = date;
  }

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    print("arg: $arguments");

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Book a service',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
        ),
        body: arguments == 'Grooming'
            ? GroomingOrderView()
            : arguments == 'Vet'
                ? VetOrderView()
                : SizedBox());
  }
}
