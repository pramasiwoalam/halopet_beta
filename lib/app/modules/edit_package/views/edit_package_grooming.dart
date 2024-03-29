import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/edit_package/controllers/edit_package_controller.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../../service_form/controllers/service_form_controller.dart';

class EditGrooming extends StatelessWidget {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  final controller = Get.put(EditPackageController());
  Map<String, dynamic> formData = {
    'name': null,
    'desc': null,
    'price': null,
    'time': null
  };

  Map<String, dynamic> groomingData = localStorage.read('groomingDataEdit');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var packageId = localStorage.read('groomingDataId');

    return Form(
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
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: "Package Name *",
                        hintText: groomingData['name'],
                        hintStyle: GoogleFonts.roboto(
                            fontSize: 14, color: Colors.grey.shade600),
                        contentPadding: EdgeInsets.all(18),
                        floatingLabelBehavior: FloatingLabelBehavior.always),
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
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: "Package Description *",
                        hintStyle: GoogleFonts.roboto(
                            fontSize: 14, color: Colors.grey.shade600),
                        hintText: groomingData['desc'],
                        contentPadding: EdgeInsets.all(18),
                        floatingLabelBehavior: FloatingLabelBehavior.always),
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
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: "Package Price *",
                        hintText: "Rp. ${groomingData['price'].toString()}",
                        hintStyle: TextStyle(
                            fontFamily: 'SanFrancisco.Light',
                            fontSize: 14,
                            color: Colors.grey.shade600),
                        contentPadding: EdgeInsets.all(18),
                        floatingLabelBehavior: FloatingLabelBehavior.always),
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
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: "Package Time Estimation *",
                        hintText: '1 hour',
                        hintStyle: GoogleFonts.roboto(
                            fontSize: 14, color: Colors.grey.shade600),
                        contentPadding: EdgeInsets.all(18),
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                    validator: (value) {
                      if (value!.contains('Wira')) {
                        return 'Wira Dilarang daftar';
                      }
                    },
                    onSaved: (value) {
                      formData['time'] = value;
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
                              controller.updateGrooming(formData, packageId),
                              Get.back()
                            }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          primary: Color(0xffF9813A),
                          shape: StadiumBorder(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Update',
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
                          primary: Colors.grey.shade100,
                          shape: StadiumBorder(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
