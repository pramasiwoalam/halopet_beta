import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () => authController.login(
                      emailController.text, passwordController.text),
                  child: Text("Login")),
              ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.SIGNUP),
                  child: Text("Register"))
            ],
          ),
        ));
  }
}
