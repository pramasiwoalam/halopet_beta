import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/pet_form_controller.dart';

class PetFormView extends GetView<PetFormController> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      controller.edited.value = true;
    } on PlatformException catch (e) {
      print(e);
    }
  }

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
            style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 15),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Obx(
                    () => Center(
                      child: Container(
                        height: height / 5,
                        width: width / 3.5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.black, width: width * 0.4),
                          image: DecorationImage(
                              fit: BoxFit.scaleDown,
                              image: controller.edited.value == false
                                  ? AssetImage('assets/images/user.png')
                                  : AssetImage('assets/images/user2.png')),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: height / 8,
                    right: 110,
                    child: GestureDetector(
                      onTap: () => pickImage(ImageSource.gallery),
                      child: Container(
                          height: height * 0.045,
                          width: height * 0.045,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: const Color(0xFFf2f2f2)),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                          child: Center(
                            child: Icon(Icons.edit),
                          )),
                    ),
                  ),
                ],
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
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: "Pet's Name *",
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                    fontFamily: 'SanFrancisco.Light'),
                                hintText: 'Write your pet name here...',
                                contentPadding: EdgeInsets.all(18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.contains('Wira')) {
                                return 'Wira Dilarang daftar';
                              }
                            },
                            onSaved: (value) {
                              formData['name'] = value;
                            },
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: "Pet's Description *",
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                    fontFamily: 'SanFrancisco.Light'),
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
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: "Birth / Adopted Date *",
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                    fontFamily: 'SanFrancisco.Light'),
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
                            style: TextStyle(
                                fontFamily: 'SanFrancisco.Regular',
                                fontSize: 14,
                                color: Colors.grey.shade700),
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
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: "Pet's Species *",
                                hintText: "Write your pet's species here...",
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                    fontFamily: 'SanFrancisco.Light'),
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
                                      hintStyle: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                          fontFamily: 'SanFrancisco.Light'),
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
                                      hintStyle: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                          fontFamily: 'SanFrancisco.Light'),
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
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                    fontFamily: 'SanFrancisco.Light'),
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
                            height: size.height * 0.06,
                            width: size.width,
                            color: Colors.transparent,
                            child: ElevatedButton(
                                onPressed: () => {
                                      if (form.currentState!.validate())
                                        {
                                          Get.dialog(AlertDialog(
                                            title: const Text(
                                              'Medical Records Option',
                                              style: TextStyle(
                                                  fontFamily: 'SanFrancisco',
                                                  fontSize: 14),
                                            ),
                                            titlePadding: EdgeInsets.only(
                                                left: 26, right: 26, top: 30),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 26,
                                                    right: 26,
                                                    top: 16,
                                                    bottom: 12),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            content: const Text(
                                                'Do you own the medical record on your previous meet with vet?',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'SanFrancisco.Light',
                                                    fontSize: 12)),
                                            actionsPadding: EdgeInsets.only(
                                                top: 6, bottom: 2),
                                            actions: [
                                              TextButton(
                                                  onPressed: () => {
                                                        Get.back(),
                                                        form.currentState!
                                                            .save(),
                                                        controller.createPets(
                                                            formData),
                                                      },
                                                  child: const Text(
                                                    'Yes, i have.',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'SanFrancisco.Light',
                                                        fontSize: 13,
                                                        color: Colors.orange),
                                                  )),
                                              TextButton(
                                                  onPressed: () => {
                                                        Get.back(),
                                                        form.currentState!
                                                            .save(),
                                                        controller.createPets(
                                                            formData),
                                                        Get.toNamed(
                                                            Routes.PET_LIST),
                                                      },
                                                  child: Text(
                                                    'No',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'SanFrancisco',
                                                        fontSize: 13,
                                                        color: Colors.orange),
                                                  )),
                                            ],
                                          ))
                                        }
                                    },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  primary: Color(0xffF9813A),
                                  shape: StadiumBorder(),
                                ),
                                child: Text("Register",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'SanFrancisco'))),
                          ),
                        ]),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
