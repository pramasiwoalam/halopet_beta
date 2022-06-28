import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../../service_form/controllers/service_form_controller.dart';

class PackageSession extends StatelessWidget {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  final controller = Get.put(ServiceFormController());
  Map<String, dynamic> formData = {
    'sessionNumber': null,
    'name': null,
    'specialist': null,
    'openHours': null,
    'openDay': null,
    'credentials': null,
    'yearsActive': null
  };

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var localStorage = GetStorage();

    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Form(
        key: form,
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              labelText: "Session Number *",
                              hintText: 'Session 1',
                              hintStyle: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.grey.shade600),
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
                          height: 25,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              labelText: "Session Doctor Name *",
                              hintStyle: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.grey.shade600),
                              hintText: 'Drh. X',
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
                        SizedBox(height: 25),
                        TextFormField(
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              labelText: "Pet Specialist",
                              hintText: 'Cat, dog',
                              hintStyle: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.grey.shade600),
                              contentPadding: EdgeInsets.all(18),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                          validator: (value) {
                            if (value!.contains('Wira')) {
                              return 'Wira Dilarang daftar';
                            }
                          },
                          onSaved: (value) {
                            formData['price'] = value;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              labelText: "Session Hours",
                              hintText: '10.00 AM - 12.00 PM',
                              hintStyle: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.grey.shade600),
                              contentPadding: EdgeInsets.all(18),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                          validator: (value) {
                            if (value!.contains('Wira')) {
                              return 'Wira Dilarang daftar';
                            }
                          },
                          onSaved: (value) {
                            formData['dimension'] = value;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              labelText: "Session Day Open",
                              hintText: 'Monday - Friday',
                              hintStyle: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.grey.shade600),
                              contentPadding: EdgeInsets.all(18),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                          validator: (value) {
                            if (value!.contains('Wira')) {
                              return 'Wira Dilarang daftar';
                            }
                          },
                          onSaved: (value) {
                            formData['dimension'] = value;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              labelText: "Doctor Credential",
                              hintText: 'Monday - Friday',
                              hintStyle: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.grey.shade600),
                              contentPadding: EdgeInsets.all(18),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                          validator: (value) {
                            if (value!.contains('Wira')) {
                              return 'Wira Dilarang daftar';
                            }
                          },
                          onSaved: (value) {
                            formData['dimension'] = value;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              labelText: "Doctor Years Active",
                              hintText: 'since 2008',
                              hintStyle: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.grey.shade600),
                              contentPadding: EdgeInsets.all(18),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                          validator: (value) {
                            if (value!.contains('Wira')) {
                              return 'Wira Dilarang daftar';
                            }
                          },
                          onSaved: (value) {
                            formData['dimension'] = value;
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: Container(
                            height: size.height * 0.07,
                            width: size.width * 0.9,
                            color: Colors.transparent,
                            child: ElevatedButton(
                              onPressed: () => {
                                if (form.currentState!.validate())
                                  {
                                    form.currentState!.save(),
                                    controller.createServiceDetail(formData),
                                    controller.packageHotelList.add(formData),
                                    localStorage.write('serviceFlag', 1),
                                    localStorage.write('packageFlag', 1),
                                    Get.toNamed(Routes.SERVICE_FORM,
                                        arguments: 'Hotel')
                                  }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                primary: Color(0xffF9813A),
                                shape: StadiumBorder(),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Register',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'SanFrancisco',
                                            color: Colors.white)),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            height: size.height * 0.07,
                            width: size.width * 0.9,
                            color: Colors.transparent,
                            child: ElevatedButton(
                              onPressed: () => {
                                Get.back(),
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                primary: Colors.white,
                                shape: StadiumBorder(),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Cancel Registration',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'SanFrancisco',
                                            color: Color(0xffF9813A))),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Color(0xffF9813A),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])),
            ),
          ],
        ),
      ),
    );
  }
}
