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
            'SignupView',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          backgroundColor: Color(0xffF9813A),
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          // padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Container(
                height: height / 4,
                color: Color(0xffF9813A),
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.02),
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
                  child: Form(
                    key: form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: nameController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z]")),
                          ],
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              labelText: "User Name *",
                              hintText: 'Name',
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
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                labelText: "Email User *",
                                hintText: 'Email',
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
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                labelText: "Password User *",
                                hintText: 'Password',
                                contentPadding: EdgeInsets.all(18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            // validator: (value) {
                            //   if (value!.contains('@')) {
                            //     return 'Error 2';
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            onSaved: (value) {
                              formData['password'] = value;
                            },
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (form.currentState!.validate()) {
                                form.currentState!.save();
                                authController.signUp(formData);
                              }
                            },
                            child: Text("Register"),
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
