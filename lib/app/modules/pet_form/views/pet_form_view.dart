import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/pet_form_controller.dart';

class PetFormView extends GetView<PetFormController> {
  final name = TextEditingController();
  GlobalKey<FormState> form = GlobalKey<FormState>();
  Map<String, dynamic> formData = {
    'name': null,
    'desc': null,
    'birth': null,
    'gender': null,
    'species': null,
    'age': null,
    'weight': null,
    'color': null
  };
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Pet Registration',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: height * 0.28,
                color: Color(0xffF9813A),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: height / 5,
                        width: width / 3.5,
                        // color: Colors.blue,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.black, width: width * 0.4),
                          image: const DecorationImage(
                              fit: BoxFit.scaleDown,
                              image: AssetImage('assets/images/user.png')),
                        ),
                      ),
                      Container(
                        width: width * 0.4,
                        height: height * 0.055,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: name,
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 15, right: 15),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1),
                              ),
                              border: const OutlineInputBorder(),
                              label: Text('Pet Name'),
                              labelStyle: GoogleFonts.roboto(
                                  fontSize: 13, color: Colors.white),
                              // hintText: 'Your pet name...',
                              hintStyle: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.white),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.auto),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: height * 0.8,
                color: Colors.white,
                child: Form(
                  key: form,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z]")),
                            ],
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: "Pet's Description *",
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.grey.shade500),
                                hintText: 'Write your pet description here...',
                                contentPadding: EdgeInsets.all(18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.contains('Wira')) {
                                return 'Wira Dilarang daftar';
                              }
                            },
                            onSaved: (value) {
                              formData['desc'] = value;
                            },
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z]")),
                            ],
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: "Birth / Adopted Date *",
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.grey.shade500),
                                hintText: '26 June 2000',
                                contentPadding: EdgeInsets.all(18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.contains('Wira')) {
                                return 'Wira Dilarang daftar';
                              }
                            },
                            onSaved: (value) {
                              formData['birth'] = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '   Gender',
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Colors.grey.shade700),
                          ),
                          CustomRadioButton(
                            elevation: 1,
                            buttonTextStyle: ButtonTextStyle(
                                selectedColor: Colors.white,
                                unSelectedColor: Colors.grey.shade700,
                                textStyle: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                    color: Colors.white)),
                            unSelectedColor: Colors.white,
                            buttonLables: const [
                              "Male",
                              "Female",
                            ],
                            buttonValues: const [
                              "Male",
                              "Female",
                            ],
                            radioButtonValue: (value) {
                              formData['gender'] = value;
                            },
                            defaultSelected: null,
                            unSelectedBorderColor: Colors.grey.shade100,
                            selectedBorderColor: Color(0xffF9813A),
                            spacing: 2,
                            horizontal: false,
                            enableButtonWrap: false,
                            height: height * 0.04,
                            // enableShape: true,
                            width: width * 0.4,
                            absoluteZeroSpacing: false,
                            selectedColor: Color(0xffF9813A),
                            padding: 10,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z]")),
                            ],
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: "Pet's Species *",
                                hintText: "Write your pet's species here...",
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.grey.shade500),
                                contentPadding: EdgeInsets.all(18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.contains('Wira')) {
                                return 'Wira Dilarang daftar';
                              }
                            },
                            onSaved: (value) {
                              formData['species'] = value;
                            },
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: size.height * 0.065,
                                width: width * 0.42,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.contains('Wira')) {
                                      return 'Wira Dilarang daftar';
                                    }
                                  },
                                  onSaved: (value) {
                                    formData['age'] = value;
                                  },
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      labelText: "Age *",
                                      hintText: "3 months",
                                      hintStyle: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Colors.grey.shade500),
                                      contentPadding: EdgeInsets.all(18),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always),
                                ),
                              ),
                              Container(
                                height: size.height * 0.065,
                                width: width * 0.42,
                                child: TextFormField(
                                  // controller: emailController,
                                  validator: (value) {
                                    if (value!.contains('Wira')) {
                                      return 'Wira Dilarang daftar';
                                    }
                                  },
                                  onSaved: (value) {
                                    formData['weight'] = value;
                                  },
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      labelText: "Weight",
                                      hintText: "... kg(s)",
                                      hintStyle: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Colors.grey.shade500),
                                      contentPadding: EdgeInsets.all(18),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: "Pet's color",
                                hintText: "Black with orange spots",
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.grey.shade500),
                                contentPadding: EdgeInsets.all(18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.contains('Wira')) {
                                return 'Wira Dilarang daftar';
                              }
                            },
                            onSaved: (value) {
                              formData['color'] = value;
                            },
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Container(
                            width: width,
                            height: height * 0.06,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (form.currentState!.validate()) {
                                    formData['name'] = name.text;

                                    form.currentState!.save();
                                    controller.createPets(formData);
                                    Get.toNamed(Routes.PET_LIST);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xffF9813A),
                                    padding: EdgeInsets.all(12),
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                child: Text('Register')),
                          )
                        ]),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
