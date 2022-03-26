import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
                children: [
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    ],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: "Grooming Description *",
                        hintText: 'Description',
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
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    ],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: "Grooming Description *",
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
                      child: Text('Register'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
