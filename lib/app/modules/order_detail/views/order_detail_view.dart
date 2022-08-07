import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/order_detail/views/order_detail_approval_view.dart';
import 'package:halopet_beta/app/modules/order_detail/views/order_detail_cancellation_view.dart';
import 'package:halopet_beta/app/modules/order_detail/views/order_detail_ongoing_view.dart';
import 'package:halopet_beta/app/modules/order_detail/views/order_detail_payment_view.dart';
import '../controllers/order_detail_controller.dart';

final reasons = TextEditingController();

class OrderDetailView extends GetView<OrderDetailController> {
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Booking Detail',
            style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 15),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
        ),
        body: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getOrder(Get.arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                localStorage.write('orderId', Get.arguments);
                var data = snapshot.data!.data() as Map<String, dynamic>;
                if (data['status'] == 'Waiting for approval') {
                  return WaitingApproval();
                } else if (data['status'] == 'Waiting for payment') {
                  return WaitingPayment();
                } else if (data['status'] == 'On Going') {
                  return OnGoing();
                } else if (data['status'] == 'Completed') {
                  return Cancellation();
                } else {
                  return Cancellation();
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
