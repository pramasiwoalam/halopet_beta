import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authController = Get.find<AuthController>();
  final controller = Get.put(LoginController());

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.35,
              width: width,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 120,
                    ),
                    Center(
                      child: Container(
                        height: height * 0.08,
                        width: width * 0.6,
                        // color: Colors.yellowAccent,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/textHalopet.png"),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Container(
              height: height * 0.45,
              width: width,
              child: Column(
                children: [
                  // Expanded(child:
                  Container(
                    height: height * 0.21,
                    width: width,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: size.height * 0.08,
                            width: size.width * 0.7,
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            margin: EdgeInsets.symmetric(vertical: 9),
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                // filled: true,
                                fillColor: Color.fromARGB(255, 255, 183, 74),
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade600, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 19, 7, 7),
                                        width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                hintText: "abc@gmail.com",
                                hintStyle: TextStyle(
                                    fontFamily: 'SanFrancisco.Regular',
                                    fontSize: 14),
                                prefixIcon: Icon(Icons.people),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Obx(
                            () => Container(
                              height: size.height * 0.066,
                              width: size.width * 0.7,
                              margin: EdgeInsets.symmetric(vertical: 2),
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: TextField(
                                obscureText: controller.obscureFlag.value == 0
                                    ? false
                                    : true,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade600,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(255, 19, 7, 7),
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  hintText: "8 characters",
                                  hintStyle: TextStyle(
                                      fontFamily: 'SanFrancisco.Regular',
                                      fontSize: 14),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    size: 16,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () => {
                                      if (controller.obscureFlag.value == 0)
                                        {
                                          print(controller.obscureFlag),
                                          controller.obscureFlag.value = 1
                                        }
                                      else
                                        {
                                          print(controller.obscureFlag),
                                          controller.obscureFlag.value = 0
                                        }
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: Icon(
                                        controller.obscureFlag.value == 0
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 18,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //

                  Container(
                    height: height * 0.05,
                    width: width * 0.5,
                    child: TextButton(
                      onPressed: () => {
                        Get.dialog(AlertDialog(
                          title: const Text(
                            'Confirmation',
                            style: TextStyle(
                                fontFamily: 'SanFrancisco', fontSize: 14),
                          ),
                          titlePadding:
                              EdgeInsets.only(left: 26, right: 26, top: 30),
                          contentPadding: const EdgeInsets.only(
                              left: 26, right: 26, top: 16, bottom: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          content: const Text(
                              'Are you sure want to reset your password?',
                              style: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 12)),
                          actionsPadding:
                              EdgeInsets.only(right: 15, top: 6, bottom: 2),
                          actions: [
                            TextButton(
                                onPressed: () => {Get.back()},
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco.Light',
                                      fontSize: 13,
                                      color: Colors.orange),
                                )),
                            TextButton(
                                onPressed: () => {
                                      Get.back(),
                                      if (emailController.text.isEmpty)
                                        {
                                          Get.dialog(AlertDialog(
                                            title: const Text(
                                              'Email is Empty',
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
                                                'Please fill the email correctly.',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'SanFrancisco.Light',
                                                    fontSize: 12)),
                                            actionsPadding: EdgeInsets.only(
                                                right: 15, top: 6, bottom: 2),
                                            actions: [
                                              TextButton(
                                                  onPressed: () => {Get.back()},
                                                  child: Text(
                                                    'Ok',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'SanFrancisco',
                                                        fontSize: 13,
                                                        color: Colors.orange),
                                                  )),
                                            ],
                                          ))
                                        }
                                      else
                                        {
                                          authController.resetPassword(
                                              emailController.text),
                                          Get.dialog(AlertDialog(
                                            title: const Text(
                                              'Reset Password',
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
                                                'Your reset password request has been sent to your email',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'SanFrancisco.Light',
                                                    fontSize: 12)),
                                            actionsPadding: EdgeInsets.only(
                                                right: 15, top: 6, bottom: 2),
                                            actions: [
                                              TextButton(
                                                  onPressed: () => {Get.back()},
                                                  child: Text(
                                                    'Ok',
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
                                child: Text(
                                  'Confirm',
                                  style: TextStyle(
                                      fontFamily: 'SanFrancisco',
                                      fontSize: 13,
                                      color: Colors.orange),
                                )),
                          ],
                        ))
                      },
                      child: Text("Forgot your password?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'SanFrancisco.Light')),
                    ),
                  ),

                  Container(
                    height: size.height * 0.06,
                    width: size.width * 0.6,
                    color: Colors.transparent,
                    child: ElevatedButton(
                        onPressed: () async {
                          try {
                            var res = await authController.login(
                                emailController.text, passwordController.text);
                            if (res != 'Success') {
                              var message = '';
                              if (res == 'invalid-email') {
                                message =
                                    'Invalid Email Form. Please check again your email.';
                              } else if (res == 'user-not-found') {
                                message =
                                    'User not found. Please check again your input.';
                              } else if (res == 'wrong-password') {
                                message =
                                    'Wrong password. Please check your input';
                              } else {
                                message = 'Email / Password must not be null.';
                              }
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.ERROR,
                                animType: AnimType.BOTTOMSLIDE,
                                title: 'Login Failed',
                                desc: message,
                                btnOkOnPress: () {},
                              ).show();
                            }
                          } catch (e) {
                            print("ERROR $e");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          primary: Color(0xffF9813A),
                          shape: StadiumBorder(),
                        ),
                        child: Text("Login",
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'SanFrancisco'))),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    height: height * 0.04,
                    width: width,
                    // color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SanFrancisco.Light')),
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child:
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () => Get.toNamed(Routes.SIGNUP),
                          // elevation: 10,
                          child: Text(
                            "Register",
                            // textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'SanFrancisco',
                              color: Colors.black,
                            ),
                          ),
                        ),

                        //
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
