import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';
import 'package:halopet_beta/app/modules/profile/views/profile_view.dart';
import 'package:halopet_beta/app/modules/seller_history/views/seller_history_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/seller_home_controller.dart';

class SellerHomeView extends GetView<SellerHomeController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final authController = Get.find<AuthController>();
  final homeController = Get.put(SellerHomeController());

  void indexAction(int index) {
    homeController.index.value = index;
  }

  List<Widget> containerList = [
    ApprovalContainer(),
    PaymentContainer(),
    OnGoingContainer(),
    CompletedContainer(),
    CancelledContainer()
  ];

  final tabs = [Home(), SellerHistoryView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(
              child: Text(
            'Booking Order',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          )),
          backgroundColor: Color(0xff2596BE),
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () => Get.toNamed(Routes.PROFILE),
            ),
          ],
          bottom: const TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  text: "Waiting for Approval",
                ),
                Tab(
                  text: "Waiting for Payment",
                ),
                Tab(
                  text: "On Going",
                ),
                Tab(
                  text: "Completed",
                ),
                Tab(
                  text: "Cancelled",
                )
              ]),
        ),
        body: TabBarView(
          children: containerList,
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final homeController = Get.put(SellerHomeController());
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: homeController.streamData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var data = snapshot.data!.docs;
              var petshopId = localStorage.read('initialPetshopId');
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    if ((data[index].data()
                                as Map<String, dynamic>)['petshopId'] ==
                            petshopId &&
                        (data[index].data()
                                as Map<String, dynamic>)['status'] !=
                            'Declined' &&
                        (data[index].data()
                                as Map<String, dynamic>)['status'] !=
                            'Done') {
                      return ListTile(
                          onTap: () => Get.toNamed(Routes.SELLER_ORDER_DETAIL,
                              arguments: data[index].id),
                          title: Text(
                              "Booking Type: ${(data[index].data() as Map<String, dynamic>)["bookingType"]}"),
                          subtitle: Text(
                              "Status: ${(data[index].data() as Map<String, dynamic>)["status"]}"));
                    } else {
                      return SizedBox();
                    }
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class ApprovalContainer extends StatefulWidget {
  const ApprovalContainer({Key? key}) : super(key: key);

  @override
  _ApprovalContainerState createState() => _ApprovalContainerState();
}

class _ApprovalContainerState extends State<ApprovalContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PaymentContainer extends StatefulWidget {
  const PaymentContainer({Key? key}) : super(key: key);

  @override
  _PaymentContainerState createState() => _PaymentContainerState();
}

class _PaymentContainerState extends State<PaymentContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class OnGoingContainer extends StatefulWidget {
  const OnGoingContainer({Key? key}) : super(key: key);

  @override
  _OnGoingContainerState createState() => _OnGoingContainerState();
}

class _OnGoingContainerState extends State<OnGoingContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CompletedContainer extends StatefulWidget {
  const CompletedContainer({Key? key}) : super(key: key);

  @override
  _CompletedContainerState createState() => _CompletedContainerState();
}

class _CompletedContainerState extends State<CompletedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CancelledContainer extends StatefulWidget {
  const CancelledContainer({Key? key}) : super(key: key);

  @override
  _CancelledContainerState createState() => _CancelledContainerState();
}

class _CancelledContainerState extends State<CancelledContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
