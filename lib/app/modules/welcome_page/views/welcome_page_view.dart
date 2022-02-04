import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halopet_beta/app/routes/auth_pages.dart';

import '../controllers/welcome_page_controller.dart';

class WelcomePageView extends GetView<WelcomePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
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
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Column(
      children: [
        Container(
          height: height * 0.6,
          width: width,
          // color: Colors.green,
          child: Column(
            children: [
              Container(
                height: height * 0.2,
                width: width,
                // color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      height: height,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/2.png"))),
                    ),
                    Container(
                      height: height,
                      width: width * 0.5,
                      // color: Colors.orange.shade300,
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.4,
                width: width * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/3.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: height * 0.4,
          width: width,
          child: Column(
            children: [
              Text(
                "Welcome to Halopet!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 30),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 98),
                    color: Colors.orange.shade400,
                    onPressed: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                    color: Colors.blue.shade100,
                    onPressed: () {
                      Get.toNamed(Routes.SIGNUP);
                    },
                    child: Text(
                      "I already have an account",
                      style: TextStyle(color: Colors.orange.shade400),
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
