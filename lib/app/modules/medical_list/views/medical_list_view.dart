import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/medical_list_controller.dart';

class MedicalListView extends GetView<MedicalListController> {
  final messageC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    var userId = GetStorage().read('currentUserId');
    var petshopId = localStorage.read('selectedPetshop');

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Medical Service List',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Container(
                height: height,
                width: width,
                child: StreamBuilder<QuerySnapshot<Object?>>(
                    stream: controller.getMedicalList(petshopId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        var data = snapshot.data!.docs;

                        return Container(
                            child: Column(
                          children: [
                            ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  var dataMap = data[index].data()
                                      as Map<String, dynamic>;

                                  return InkWell(
                                      onTap: () => {
                                            AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.QUESTION,
                                                animType: AnimType.BOTTOMSLIDE,
                                                btnCancelText: 'No',
                                                btnOkText: 'Yes',
                                                title: 'Choose Delivery',
                                                desc:
                                                    'Are you want to order with delivery?',
                                                btnCancelOnPress: () => {
                                                      localStorage.write(
                                                          'medName',
                                                          dataMap['name']),
                                                      Get.toNamed(
                                                          Routes.CREATE_ORDER,
                                                          arguments: "Vet")
                                                    },
                                                btnOkOnPress: () => {
                                                      Get.toNamed(
                                                          Routes.DELIVERY_LIST,
                                                          arguments: "Vet")
                                                    }).show(),
                                          },
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 22, right: 22, top: 24),
                                          child: Container(
                                              height: height * 0.12,
                                              width: width,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors
                                                            .grey.shade200,
                                                        spreadRadius: 2,
                                                        blurRadius: 3,
                                                        offset: Offset(0, 4))
                                                  ],
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          Colors.grey.shade200),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 24,
                                                  top: 12,
                                                  bottom: 12,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: width * 0.6,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Service Name',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'SanFrancisco.Light',
                                                                fontSize: 10),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Text(
                                                            dataMap['name'],
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'SanFrancisco',
                                                                fontSize: 15),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Text(
                                                            dataMap['desc'],
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'SanFrancisco.Light',
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width * 0.2,
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          size: 21,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ))));
                                }),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ));
                      } else {
                        return Container();
                      }
                    }))));
  }
}
