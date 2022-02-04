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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.52,
              width: width,
              // color: Colors.red,
              child: Column(
                children: [
                  SizedBox(height: 55),
                  Text("Welcome to",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 5),
                  Container(
                    height: height * 0.06,
                    width: width * 0.3,
                    // color: Colors.amber,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/textHalopet.png"),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    height: height * 0.30,
                    width: width,
                    // color: Colors.yellowAccent,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/3.png"),
                          fit: BoxFit.contain),
                    ),
                  ),
                  Container(
                    height: height * 0.03,
                    width: width,
                    // color: Colors.yellow,
                    child: Text(
                      "Login in with",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: height * 0.48,
              width: width,
              // color: Colors.blue,
              child: Column(
                children: [
                  Container(
                    height: height * 0.04,
                    width: width,
                    // color: Colors.green,
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.04,
                          width: width * 0.3,
                          color: Colors.transparent,
                          child: MaterialButton(
                            onPressed: () {},
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: height,
                                  width: width * 0.2,
                                  decoration: BoxDecoration(
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
                    height: height * 0.02,
                    width: width,
                    // color: Colors.amber,
                    child: Text("or",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    height: height * 0.2,
                    width: width,
                    // color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: size.height * 0.07,
                          width: size.width * 0.65,
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          margin: EdgeInsets.symmetric(vertical: 6),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2.0),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                hintText: "abc@gmail.com",
                                prefixIcon: Icon(Icons.people),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          height: size.height * 0.07,
                          width: size.width * 0.65,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2.0),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                hintText: "8 characters",
                                prefixIcon: Icon(Icons.lock),
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.05,
                    width: width,
                    // color: Colors.green,
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.04,
                          width: width * 0.8,
                          color: Colors.transparent,
                          child: MaterialButton(
                            onPressed: () {},
                            elevation: 10,
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
                        onPressed: () => authController.login(
                            emailController.text, passwordController.text),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          primary: Colors.orange,
                          shape: StadiumBorder(),
                        ),
                        child: Text("Login",
                            style: GoogleFonts.roboto(
                                fontSize: 17, fontWeight: FontWeight.w500))),
                  ),
                  Container(
                    height: height * 0.03,
                    width: width,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // color: Colors.green,
                    child: Row(
                      children: [
                        Container(
                          height: height,
                          width: width * 0.55,
                          margin: EdgeInsets.symmetric(vertical: 3),
                          child: Text("Don't have an account?",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                  fontSize: 12, fontWeight: FontWeight.w500)),
                        ),
                        Container(
                          height: height,
                          width: width * 0.19,
                          margin: EdgeInsets.symmetric(vertical: 3),
                          // color: Colors.brown,
                          child: MaterialButton(
                            onPressed: () {},
                            elevation: 10,
                            child: Text(
                              "Register",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        )
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
