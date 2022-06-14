import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import 'package:money_formatter/money_formatter.dart';

import '../../choose_session/controllers/choose_session_controller.dart';
import '../../session_list/controllers/session_list_controller.dart';
import '../controllers/session_detail_controller.dart';

final balanceController = TextEditingController();

class SessionDetailView extends GetView<SessionDetailController> {
  @override
  Widget build(BuildContext context) {
    final localStorage = GetStorage();
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var sessionId = Get.arguments;
    final sessionController = Get.put(ChooseSessionController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Session Detail',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        backgroundColor: Color(0xffF9813A),
        elevation: 0,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getSessionDetail(sessionId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              return Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Container(
                      height: height * 0.50,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(0, 2))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Session',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.black)),
                            const Divider(
                              thickness: 1,
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Session',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Colors.grey.shade500)),
                                Text(data['number'],
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color: Colors.grey.shade500))
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Session Time',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Colors.grey.shade500)),
                                Text(data['openHours'],
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color: Colors.grey.shade500))
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Session Day Open',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Colors.grey.shade500)),
                                Text(data['day'],
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color: Colors.grey.shade500))
                              ],
                            ),
                            Spacer(),
                            const SizedBox(
                              height: 2,
                            ),
                            Spacer(),
                            Text('Vet Detail',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: Colors.black)),
                            const Divider(
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Doctor Name',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Colors.grey.shade500)),
                                Text(data['name'],
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Colors.grey.shade500)),
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Specialist',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Colors.grey.shade500)),
                                Text(data['specialist'],
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Colors.grey.shade500)),
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Years Active',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Colors.grey.shade500)),
                                Text("since ${data['yearsActive']}",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Colors.grey.shade500)),
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Vet Credential(s)',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Colors.grey.shade500)),
                                Text(data['credential'],
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Colors.grey.shade500)),
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Vet Description',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Colors.grey.shade500)),
                                Text(data['desc'],
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Colors.grey.shade500)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () => {Get.toNamed(Routes.MEDICAL_LIST)},
                      child: Container(
                        margin: EdgeInsets.only(top: height * 0.025),
                        width: width * 0.82,
                        height: height * 0.07,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 3,
                                  blurRadius: 4,
                                  offset: Offset(0, 4))
                            ],
                            color: Color(0xffF9813A),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                            padding: EdgeInsets.only(left: 30, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Select this Session',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Colors.white)),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 22,
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () => {Get.back()},
                      child: Container(
                        margin: EdgeInsets.only(top: height * 0.025),
                        width: width * 0.82,
                        height: height * 0.07,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 3,
                                  blurRadius: 4,
                                  offset: Offset(0, 4))
                            ],
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                            padding: EdgeInsets.only(left: 30, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Back to Session List',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Color(0xffF9813A))),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xffF9813A),
                                  size: 22,
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
