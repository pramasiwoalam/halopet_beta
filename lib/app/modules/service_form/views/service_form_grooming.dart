import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/service_list/controllers/service_list_controller.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/service_form_controller.dart';

class GroomingService extends StatelessWidget {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  final controller = Get.put(ServiceListController());
  Map<String, dynamic> formData = {'desc': null, 'price': null};

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var localStorage = GetStorage();

    return Form(
      key: form,
      child: Stack(
        children: [
          Container(
            height: height / 4,
            color: Color(0xffF9813A),
          ),
          Container(
            margin: EdgeInsets.only(top: height * 0.015),
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    ],
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: "Grooming Description *",
                        hintText: 'Description',
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
                      formData['desc'] = value;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    ],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: "Grooming Description *",
                        hintStyle: GoogleFonts.roboto(
                            fontSize: 14, color: Colors.grey.shade600),
                        hintText: 'Description',
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
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '    Register Package(s) *',
                    style: GoogleFonts.roboto(
                        fontSize: 14, color: Colors.grey.shade700),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    height: height * 0.06,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(0, 3))
                        ]),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_rounded,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Add Package',
                          style: GoogleFonts.roboto(
                              fontSize: 14, color: Colors.grey.shade700),
                        )
                      ],
                    )),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (form.currentState!.validate()) {
                          form.currentState!.save();
                          print('asd: $formData');
                          controller.createPetshop(formData);
                          localStorage.write('grooming', true);
                          Get.toNamed(Routes.SERVICE_LIST);
                        }
                      },
                      child: Text('Register')),
                  ElevatedButton(
                      onPressed: () => {
                            Get.back(),
                            controller.cancellation(
                                localStorage.read('savedPetshopId'),
                                localStorage.read('savedServiceId'))
                          },
                      child: Text('Back To Service List'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
