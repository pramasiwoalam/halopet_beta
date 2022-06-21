import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../controllers/medical_records_form_controller.dart';

class MedicalRecordsFormView extends GetView<MedicalRecordsFormController> {
  final name = TextEditingController();
  GlobalKey<FormState> form = GlobalKey<FormState>();
  Map<String, dynamic> formData = {
    'info': null,
    'date': null,
    'author': null,
  };
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    void setValue(DateTime dateTime) {
      var date = DateFormat('MMMM dd, yyyy').format(dateTime);
      controller.date.value = date.toString();
      controller.date.value = date;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Medical Record Registration',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 17),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
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
                          Obx(
                            () => FlatButton(
                              onPressed: () => {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2023))
                                    .then((value) => {setValue(value!)})
                              },
                              child: Container(
                                height: height * 0.08,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade300),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0,
                                      bottom: 12,
                                      left: 20,
                                      right: 20),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        controller.date == "null"
                                            ? const Text(
                                                'Medical Records Created Date',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'SanFrancisco.Light',
                                                    fontSize: 13),
                                              )
                                            : Text(
                                                controller.date.value
                                                    .toString(),
                                                style: TextStyle(
                                                  fontFamily:
                                                      'SanFrancisco.Regular',
                                                  color: Colors.grey.shade700,
                                                  fontSize: 14,
                                                ),
                                              ),
                                        controller.date == "null"
                                            ? Icon(
                                                Icons.calendar_month,
                                                size: 22,
                                                color: Colors.orange,
                                              )
                                            : Icon(
                                                Icons.calendar_month,
                                                size: 22,
                                                color: Colors.orange,
                                              )
                                      ]),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
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
                                labelText: "Medical Records Info *",
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.grey.shade500),
                                hintText: 'Write your medical records here...',
                                contentPadding: EdgeInsets.all(18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.contains('Wira')) {
                                return 'Wira Dilarang daftar';
                              }
                            },
                            onSaved: (value) {
                              formData['info'] = value;
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
                                labelText: "Author *",
                                hintText:
                                    "Write your medical record author here...",
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
                              formData['author'] = value;
                            },
                          ),
                          SizedBox(
                            height: 18,
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
                                              'Register Confirmation',
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
                                                'Are you sure the registered data is correct?',
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
                                                      },
                                                  child: const Text(
                                                    'Cancel',
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
                                                        controller
                                                            .createMedicalRecords(
                                                                formData),
                                                      },
                                                  child: Text(
                                                    'Yes',
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
