import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/service_form_controller.dart';

class VetService extends StatelessWidget {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  final controller = Get.put(ServiceFormController());
  Map<String, dynamic> formData = {
    'number': null,
    'day': null,
    'name': null,
    'openHoursStart': null,
    'openHoursEnd': null,
    'specialist': null,
    'desc': null,
    'yearsActive': null
  };

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
        width: width,
        height: height,
        child: Form(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText: "Session Number",
                            hintText: 'Session 1',
                            hintStyle: TextStyle(
                                fontFamily: 'SanFrancisco.Regular',
                                fontSize: 14,
                                color: Colors.grey.shade600),
                            contentPadding: EdgeInsets.all(18),
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always),
                        validator: (value) {
                          if (value!.contains('Wira')) {
                            return 'Wira Dilarang daftar';
                          }
                        },
                        onSaved: (value) {
                          formData['number'] = value;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText: "Session Day(s)",
                            hintText: 'Monday, Wednesday, Friday',
                            hintStyle: TextStyle(
                                fontFamily: 'SanFrancisco.Regular',
                                fontSize: 14,
                                color: Colors.grey.shade600),
                            contentPadding: EdgeInsets.all(18),
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always),
                        validator: (value) {
                          if (value!.contains('Wira')) {
                            return 'Wira Dilarang daftar';
                          }
                        },
                        onSaved: (value) {
                          formData['day'] = value;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  labelText: "Open Hours *",
                                  hintText: '07.00 am',
                                  hintStyle: TextStyle(
                                      fontSize: 14,
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
                                formData['openHoursStart'] = value;
                              },
                            ),
                          ),
                          Flexible(
                              child: Container(
                                  width: width * 0.1,
                                  child: Center(
                                      child: Text(
                                    'until',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600),
                                  )))),
                          Flexible(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          const Radius.circular(20))),
                                  labelText: "Open Hours *",
                                  hintText: '21.00 pm',
                                  hintStyle: TextStyle(
                                      fontSize: 14,
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
                                formData['openHoursEnd'] = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText:
                                "Doctor Name (with bachelor or specialist)*",
                            hintStyle: TextStyle(
                                fontFamily: 'SanFrancisco.Regular',
                                fontSize: 14,
                                color: Colors.grey.shade600),
                            hintText: 'Drh. Lorem Ipsum S.Ked',
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
                      SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText: "Doctor Specialist *",
                            hintText: 'Dog Specialist',
                            hintStyle: TextStyle(
                                fontFamily: 'SanFrancisco.Regular',
                                fontSize: 14,
                                color: Colors.grey.shade600),
                            contentPadding: EdgeInsets.all(18),
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always),
                        validator: (value) {
                          if (value!.contains('Wira')) {
                            return 'Wira Dilarang daftar';
                          }
                        },
                        onSaved: (value) {
                          formData['specialist'] = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText: "Years Active *",
                            hintText: '2008',
                            hintStyle: TextStyle(
                                fontFamily: 'SanFrancisco.Regular',
                                fontSize: 14,
                                color: Colors.grey.shade600),
                            contentPadding: EdgeInsets.all(18),
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always),
                        validator: (value) {
                          if (value!.contains('Wira')) {
                            return 'Wira Dilarang daftar';
                          }
                        },
                        onSaved: (value) {
                          formData['yearsActive'] = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        maxLines: null,
                        minLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText: "Doctor Description",
                            hintText:
                                'Experienced from 2008, graduated from University of Indonesia.',
                            hintStyle: TextStyle(
                                fontFamily: 'SanFrancisco.Regular',
                                fontSize: 14,
                                color: Colors.grey.shade600),
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
                        height: 15,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (form.currentState!.validate()) {
                              form.currentState!.save();
                              controller.createSession(formData);

                              Get.toNamed(Routes.SESSION_LIST,
                                  arguments: 'Grooming');
                            }
                          },
                          child: Text('Register')),
                      ElevatedButton(
                          onPressed: () => {Get.toNamed(Routes.SESSION_LIST)},
                          child: Text('Back To Service List'))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
