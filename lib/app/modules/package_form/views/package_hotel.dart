import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../../service_form/controllers/service_form_controller.dart';

class PackageHotel extends StatelessWidget {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  final controller = Get.put(ServiceFormController());
  Map<String, dynamic> formData = {
    'name': null,
    'desc': null,
    'price': null,
    'time': null
  };

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
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: "Room Name *",
                        hintText: 'Room A',
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
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: "Room Description *",
                        hintStyle: GoogleFonts.roboto(
                            fontSize: 14, color: Colors.grey.shade600),
                        hintText: 'Air Conditioner',
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
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: "Room Price * (1 night)",
                        hintText: 'Rp. 100.000 / night',
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
                      formData['price'] = value;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText:
                            "Room Dimension * (length x width x height) in cm)",
                        hintText: '100 cm x 200 x 300 cm',
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
                      formData['dimension'] = value;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (form.currentState!.validate()) {
                          form.currentState!.save();
                          controller.createServiceDetail(formData);
                          controller.packageHotelList.add(formData);
                          localStorage.write('serviceFlag', 1);
                          localStorage.write('packageFlag', 1);

                          Get.toNamed(Routes.SERVICE_FORM, arguments: 'Hotel');
                        }
                      },
                      child: Text('Register')),
                  ElevatedButton(
                      onPressed: () => {Get.toNamed(Routes.SERVICE_LIST)},
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