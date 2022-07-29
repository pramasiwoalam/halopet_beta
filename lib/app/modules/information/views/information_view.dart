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
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            height: height,
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('   Choose your pet',
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'SanFrancisco',
                            color: Colors.grey.shade700)),
                    SizedBox(
                      height: 2,
                    ),
                    CustomRadioButton(
                      elevation: 1,
                      buttonTextStyle: ButtonTextStyle(
                          selectedColor: Colors.white,
                          unSelectedColor: Color(0xffF9813A),
                          textStyle: TextStyle(
                              fontFamily: 'SanFrancisco',
                              fontSize: 12,
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
                      height: height * 0.03,
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
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'SanFrancisco',
                                      color: Colors.grey.shade700)),
                              SizedBox(
                                height: 2,
                              ),
                              CustomRadioButton(
                                elevation: 1,
                                buttonTextStyle: ButtonTextStyle(
                                    selectedColor: Colors.white,
                                    unSelectedColor: Color(0xffF9813A),
                                    textStyle: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'SanFrancisco',
                                        color: Colors.grey.shade700)),
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
                                height: height * 0.035,
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
                                      controller.petType.value =
                                          value.toString();
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
    height: height * 0.7,
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
              style: TextStyle(
                  fontFamily: 'SanFrancisco',
                  fontSize: 13,
                  color: Colors.grey.shade800)),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 7,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cara merawat',
                  style: TextStyle(
                      fontFamily: 'SanFrancisco',
                      fontSize: 13,
                      color: Colors.grey.shade800)),
              SizedBox(
                height: 5,
              ),
              Text(
                  "1. Menyediakannya kandang yang nyaman sebagai tempat tinggal. Pastikan kamu juga sudah mengetahui jenis kandang yang tepat, karena setiap hewan memiliki kriteria kandang yang berbedabeda. Misalnya seperti kandang untuk kucing biasanya dilengkapi alas tidur yang nyaman untuk beristirahat. Kamu bisa menggunakan alas tidur yang terbuat dari kain, selimut, handuk, dan lain sebagainya. Hal ini supaya bulu dari kucing tidak mudah rontok dan terserang serangga yang merugikan kucing tersebut seperti kutu. \n\n2. Menyediakan makanan dan minuman yang sehat. Agar hewan peliharaan kesayangan Anda tumbuh sehat, Anda perlu memberi mereka makanan dan minuman yang sehat. Pada saat yang sama, Anda juga dapat menghindari masalah kesehatan, yaitu penyakit tertentu yang dapat datang ke hewan peliharaan Anda kapan saja. Ini karena makanan yang tertinggal di ruang makan dapat memicu penyebaran bakteri dan virus yang dapat menginfeksi hewan peliharaan. \n\n3.  Kotoran hewan yang benar-benar bersih, tumpukan debu dapat menyebabkan penyakit yang dapat membahayakan kesehatan hewan peliharaan Anda.",
                  style: TextStyle(
                      fontFamily: 'SanFrancisco.Light',
                      fontSize: 12,
                      color: Colors.grey.shade800))
            ],
          ),
        ],
      ),
    ),
  );
}
