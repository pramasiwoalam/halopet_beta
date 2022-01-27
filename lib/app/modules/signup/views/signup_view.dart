import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SignupView'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () => authController.signUp(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                      ),
                  child: Text("Register"))
            ],
          ),
        ));
  }
}
