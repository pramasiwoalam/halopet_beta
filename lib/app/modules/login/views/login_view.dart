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
              height: height * 0.45,
              width: width,
              // color: Colors.red,
              child: Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    Text("Welcome to",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    // SizedBox(height: 10),
                    // Container(
                    //   height: height * 0.07,
                    //   width: width * 0.35,
                    //   // color: Colors.amber,
                    //   decoration: const BoxDecoration(
                    //       image: DecorationImage(
                    //           image:
                    //               AssetImage("assets/images/textHalopet.png"),
                    //           fit: BoxFit.cover)),
                    // ),
                    SizedBox(height: 17),
                    Container(
                      height: height * 0.16,
                      width: width * 0.65,
                      // color: Colors.yellowAccent,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/textHalopet.png"),
                            fit: BoxFit.contain),
                      ),
                    ),
                    SizedBox(height: 37),
                    Container(
                      height: height * 0.03,
                      width: width,
                      // color: Colors.yellow,
                      child: const Text(
                        "Login in with",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: height * 0.5,
              width: width,
              // color: Colors.blue,
              child: Column(
                children: [
                  // Expanded(child:
                  Container(
                    height: height * 0.21,
                    width: width,
                    // color: Colors.brown,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
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
                              decoration: const InputDecoration(
                                // filled: true,
                                fillColor: Color.fromARGB(255, 255, 183, 74),
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 19, 7, 7),
                                        width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                hintText: "abc@gmail.com",
                                prefixIcon: Icon(Icons.people),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * 0.073,
                            width: size.width * 0.7,
                            margin: EdgeInsets.symmetric(vertical: 2),
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: const InputDecoration(
                                // filled: true,
                                // fillColor: Color.fromARGB(255, 236, 236, 236),
                                // isDense: true,

                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 19, 7, 7),
                                        width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                hintText: "8 characters",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  size: 20,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //

                  Container(
                    height: height * 0.042,
                    width: width * 0.4,
                    // color: Colors.red,
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.042,
                          width: width * 0.8,
                          color: Colors.transparent,
                          child: MaterialButton(
                            onPressed: () {},
                            elevation: 5,
                            child: Text("Forgot your password?",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                    fontSize: 12, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * 0.07,
                    width: size.width * 0.5,
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
                          primary: Colors.orange,
                          shape: StadiumBorder(),
                        ),
                        child: Text("Login",
                            style: GoogleFonts.roboto(
                                fontSize: 17, fontWeight: FontWeight.w500))),
                  ),
                  // Container(
                  //   height: height * 0.13,
                  //   width: width,
                  //   margin: EdgeInsets.symmetric(vertical: 5),
                  //   color: Colors.green,
                  //   child: Column(
                  //     children: [
                  Container(
                    height: height * 0.03,
                    width: width,
                    // color: Colors.amber,
                    child: Text("or",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    height: height * 0.04,
                    width: width,
                    // color: Colors.green,
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.04,
                          width: width * 0.29,
                          // color: Colors.yellow,
                          child: MaterialButton(
                            onPressed: () {},
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: height,
                                  width: width * 0.18,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/google1.png"),
                                        fit: BoxFit.cover),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: height * 0.04,
                    width: width,
                    // color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: height * 0.027,
                          width: width * 0.55,
                          // color: Colors.green,
                          margin: EdgeInsets.symmetric(vertical: 6),
                          child: Text("Don't have an account?",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 12, fontWeight: FontWeight.w500)),
                        ),
                        Container(
                          height: height * 0.037,
                          width: width * 0.4,
                          // margin: EdgeInsets.symmetric(vertical: 3),
                          // color: Colors.brown,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: MaterialButton(
                              onPressed: () => Get.toNamed(Routes.SIGNUP),
                              elevation: 10,
                              child: Text(
                                "Register",
                                // textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          //
                        )
                      ],
                    ),
                  ),
                  // Container(
                  //   height: height * 0.034,
                  //   width: width * 0.25,
                  //   // margin: EdgeInsets.symmetric(vertical: 3),
                  //   // color: Colors.brown,
                  //   child: MaterialButton(
                  //     onPressed: () => Get.toNamed(Routes.SIGNUP),
                  //     elevation: 10,
                  //     child: Text(
                  //       "Register",
                  //       textAlign: TextAlign.center,
                  //       style: GoogleFonts.roboto(
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.w500,
                  //         color: Colors.black,
                  //         decoration: TextDecoration.underline,
                  //       ),
                  //     ),
                  //   ),
                  // )
                  //     ],
                  //   ),
                  // ),
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
