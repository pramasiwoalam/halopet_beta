import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';

import '../controllers/information_controller.dart';

class InformationView extends GetView<InformationController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final authController = Get.find<AuthController>();
  final profileController = Get.put(InformationController());
  var userId = GetStorage().read('currentUserId');
  var userRole = ''.obs;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Information Centre',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 17),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
        ),
        body: Container(
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('   Choose your pet',
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade700)),
              SizedBox(
                height: 2,
              ),
              CustomRadioButton(
                elevation: 1,
                buttonTextStyle: ButtonTextStyle(
                    selectedColor: Colors.white,
                    unSelectedColor: Color(0xffF9813A),
                    textStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: Colors.white)),
                unSelectedColor: Colors.white,
                buttonLables: const [
                  "Cat",
                  "Dog",
                ],
                buttonValues: const [
                  "cat",
                  "dog",
                ],
                radioButtonValue: (value) {
                  controller.petType.value = value.toString();
                },
                defaultSelected: null,
                unSelectedBorderColor: Colors.grey.shade100,
                selectedBorderColor: Color(0xffF9813A),
                spacing: 1,
                horizontal: false,
                enableButtonWrap: false,
                height: height * 0.04,
                enableShape: false,
                width: width * 0.42,
                absoluteZeroSpacing: false,
                selectedColor: Color(0xffF9813A),
                padding: 10,
              ),
              Obx(() => controller.petType.value == 'cat'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Text('   Choose your cat type',
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700)),
                        SizedBox(
                          height: 2,
                        ),
                        CustomRadioButton(
                          elevation: 1,
                          buttonTextStyle: ButtonTextStyle(
                              selectedColor: Colors.white,
                              unSelectedColor: Color(0xffF9813A),
                              textStyle: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Colors.white)),
                          unSelectedColor: Colors.white,
                          buttonLables: const [
                            "Domestik",
                            "Persia",
                            "Anggora",
                            "Siam",
                            "Sphynx",
                            "Scottish Fold"
                          ],
                          buttonValues: const [
                            "domestik",
                            "persia",
                            "anggora",
                            "siam",
                            "sphynx",
                            "sf"
                          ],
                          radioButtonValue: (value) {
                            controller.catType.value = value.toString();
                          },
                          defaultSelected: null,
                          unSelectedBorderColor: Colors.grey.shade100,
                          selectedBorderColor: Color(0xffF9813A),
                          spacing: 1,
                          horizontal: false,
                          enableButtonWrap: false,
                          height: height * 0.04,
                          enableShape: false,
                          width: width * 0.3,
                          absoluteZeroSpacing: false,
                          selectedColor: Color(0xffF9813A),
                          padding: 10,
                        ),
                        Obx(() => controller.catType.value == 'domestik'
                            ? catDomestik(context)
                            : Container())
                      ],
                    )
                  : controller.petType.value == 'dog'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 12,
                            ),
                            Text('   Choose your dog type',
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade700)),
                            SizedBox(
                              height: 2,
                            ),
                            CustomRadioButton(
                              elevation: 1,
                              buttonTextStyle: ButtonTextStyle(
                                  selectedColor: Colors.white,
                                  unSelectedColor: Color(0xffF9813A),
                                  textStyle: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: Colors.white)),
                              unSelectedColor: Colors.white,
                              buttonLables: const [
                                "Domestik",
                                "Hachiko",
                                "Beagle",
                                "Cihuahua",
                                "Pomeranian",
                                "Poodle"
                              ],
                              buttonValues: const [
                                "domestik",
                                "hachiko",
                                "beagle",
                                "cihuahua",
                                "pomeranian",
                                "poodle"
                              ],
                              radioButtonValue: (value) {
                                controller.petType.value = value.toString();
                              },
                              defaultSelected: null,
                              unSelectedBorderColor: Colors.grey.shade100,
                              selectedBorderColor: Color(0xffF9813A),
                              spacing: 1,
                              horizontal: false,
                              enableButtonWrap: false,
                              height: height * 0.04,
                              enableShape: false,
                              width: width * 0.3,
                              absoluteZeroSpacing: false,
                              selectedColor: Color(0xffF9813A),
                              padding: 10,
                            ),
                          ],
                        )
                      : SizedBox()),
            ]),
          ),
        ));
  }
}

Widget catDomestik(BuildContext context) {
  var size = MediaQuery.of(context).size;
  var height = size.height;
  var width = size.width;
  return Container(
    margin: EdgeInsets.only(top: height * 0.02),
    height: height * 0.45,
    width: width * 0.9,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
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
          Text('Domestic Cat',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.grey.shade800)),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 7,
          ),
          Column(
            children: [
              Text('Cara merawat',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.grey.shade500)),
              Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.grey.shade500))
            ],
          ),
        ],
      ),
    ),
  );
}
