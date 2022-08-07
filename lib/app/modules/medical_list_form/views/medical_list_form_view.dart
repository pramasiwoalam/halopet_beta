import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/medical_list_reg/controllers/medical_list_reg_controller.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../../service_list/controllers/service_list_controller.dart';
import '../controllers/medical_list_form_controller.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class Days {
  final int id;
  final String name;

  Days({
    required this.id,
    required this.name,
  });
}

class MedicalListFormView extends GetView<MedicalListFormController> {
  final serviceController = Get.put(MedicalListRegController());
  final controller = Get.put(MedicalListFormController());

  Map<String, dynamic> formData = {
    'name': null,
    'desc': null,
  };

  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var localStorage = GetStorage();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medical List Registration',
          style: TextStyle(
              fontFamily: 'SanFrancisco',
              fontSize: 15,
              color: Colors.grey.shade800),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
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
                padding: const EdgeInsets.only(
                    left: 25, bottom: 25, right: 25, top: 10),
                child: Form(
                  key: form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: "Service Name *",
                            hintText: 'Name',
                            hintStyle: TextStyle(
                                fontFamily: 'SanFrancisco.Light',
                                fontSize: 13,
                                color: Colors.grey.shade600),
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
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelText: "Description *",
                              hintText: 'Description',
                              hintStyle: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 13,
                                  color: Colors.grey.shade600),
                              contentPadding: EdgeInsets.all(18),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                          validator: (value) {
                            if (value!.contains('@')) {
                              return 'Error 2';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            formData['desc'] = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: size.height * 0.07,
                        width: size.width * 0.9,
                        color: Colors.transparent,
                        child: ElevatedButton(
                          onPressed: () => {
                            if (form.currentState!.validate())
                              {
                                Get.dialog(AlertDialog(
                                  title: Text(
                                    'Confirmation',
                                    style: TextStyle(
                                        fontFamily: 'SanFrancisco',
                                        fontSize: 14),
                                  ),
                                  titlePadding: EdgeInsets.only(
                                      left: 26, right: 26, top: 30),
                                  contentPadding: EdgeInsets.only(
                                      left: 26, right: 26, top: 16, bottom: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  content: Text(
                                      'Are you the data is correct? Confirm to create service.',
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco.Light',
                                          fontSize: 12)),
                                  actionsPadding: EdgeInsets.only(
                                      right: 12, top: 6, bottom: 2),
                                  actions: [
                                    TextButton(
                                        onPressed: () => {Get.back()},
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontFamily: 'SanFrancisco.Light',
                                              fontSize: 13,
                                              color: Color(0xffF9813A)),
                                        )),
                                    TextButton(
                                        onPressed: () => {
                                              if (form.currentState!.validate())
                                                {
                                                  form.currentState!.save(),
                                                  Get.back(),
                                                  controller
                                                      .registerMedicalService(
                                                          formData),
                                                  serviceController.medicalList
                                                      .add(formData),
                                                  localStorage.write(
                                                      'vetFlag', true),
                                                  Get.toNamed(
                                                      Routes.MEDICAL_LIST_REG),
                                                }
                                            },
                                        child: Text(
                                          'Confirm',
                                          style: TextStyle(
                                              fontFamily: 'SanFrancisco',
                                              fontSize: 13,
                                              color: Color(0xffF9813A)),
                                        )),
                                  ],
                                ))
                              },
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
                              children: const [
                                Text("Save",
                                    style: TextStyle(
                                      fontFamily: 'SanFrancisco',
                                      fontSize: 15,
                                      color: Colors.white,
                                    )),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
