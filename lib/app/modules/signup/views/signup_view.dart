import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final signUpController = Get.put(SignupController());
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authController = Get.find<AuthController>();

  Map<String, dynamic> formData = {
    'name': null,
    'email': null,
    'password': null,
    'phone': null,
    'district': null,
    'city': null,
    'address': null,
    'postalCode': null,
  };

  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    FocusNode inputNode = FocusNode();
    var height = size.height;
    var width = size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Register',
            style: TextStyle(
                fontFamily: 'SanFrancisco', fontSize: 16, color: Colors.white),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.only(left: 15),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              iconSize: 19,
              onPressed: () => {Get.back()},
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          // padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Container(
                height: height / 4,
                width: width,
                color: Color(0xffF9813A),
              ),
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
                      left: 25, right: 25, bottom: 25, top: 10),
                  child: Form(
                    key: form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              labelText: "Name *",
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                fontFamily: 'SanFrancisco.Light',
                                fontSize: 13,
                              ),
                              contentPadding: EdgeInsets.all(18),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name must be filled.';
                            }
                          },
                          onSaved: (value) {
                            formData['name'] = value;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                labelText: "Email *",
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 13,
                                ),
                                contentPadding: EdgeInsets.all(18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.contains('@')) {
                              } else {
                                return 'Email not valid';
                              }
                            },
                            onSaved: (value) {
                              formData['email'] = value;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                labelText: "Password *",
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 13,
                                ),
                                contentPadding: EdgeInsets.all(18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 8) {
                                return 'Password must be 8 characters or more.';
                              }
                            },
                            onSaved: (value) {
                              formData['password'] = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: "Phone Number *",
                                hintText: '0812xxxxxx',
                                hintStyle: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 13,
                                ),
                                contentPadding: EdgeInsets.all(18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Phone number must be filled.';
                              }
                            },
                            onSaved: (value) {
                              formData['phone'] = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: "Address *",
                                hintText: 'Willow Street',
                                hintStyle: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 13,
                                ),
                                contentPadding: EdgeInsets.all(18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Address must be filled.';
                              }
                            },
                            onSaved: (value) {
                              formData['address'] = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: "District *",
                                hintText: 'District',
                                hintStyle: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 13,
                                ),
                                contentPadding: EdgeInsets.all(18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Address must be filled.';
                              }
                            },
                            onSaved: (value) {
                              formData['district'] = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Container(
                              width: width * 0.4,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    labelText: "City *",
                                    hintText: 'Jakarta',
                                    hintStyle: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 13,
                                    ),
                                    contentPadding: EdgeInsets.all(18),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Mandatory';
                                  }
                                },
                                onSaved: (value) {
                                  formData['city'] = value;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                              width: width * 0.4,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    labelText: "Postal Code *",
                                    hintText: '11250',
                                    hintStyle: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 13,
                                    ),
                                    contentPadding: EdgeInsets.all(18),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Mandatory';
                                  }
                                },
                                onSaved: (value) {
                                  formData['postalCode'] = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Container(
                            height: size.height * 0.06,
                            width: size.width * 0.8,
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
                                                        authController
                                                            .signUp(formData)
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
                        ),
                      ],
                    ),
                  ),
                ),
                // child: Column(
                //   children: [
                //     TextField(
                //       controller: nameController,
                //       decoration: InputDecoration(labelText: "Name"),
                //     ),
                //     TextField(
                //       controller: emailController,
                //       decoration: InputDecoration(labelText: "Email"),
                //     ),
                //     TextField(
                //       controller: passwordController,
                //       decoration: InputDecoration(labelText: "Password"),
                //     ),
                //     SizedBox(
                //       height: 20,
                //     ),
                //     ElevatedButton(
                //         onPressed: () => authController.signUp(
                //               nameController.text,
                //               emailController.text,
                //               passwordController.text,
                //             ),
                //         child: Text("Register"))
                //   ],
                // ),
              ),
            ],
          ),
        ));
  }
}
