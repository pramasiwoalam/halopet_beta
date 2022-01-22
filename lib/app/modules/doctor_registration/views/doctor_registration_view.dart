import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/doctor_registration_controller.dart';

class DoctorRegistrationView extends GetView<DoctorRegistrationController> {

  final dName = TextEditingController();
  final dDescription = TextEditingController();
  final doctorController = Get.put(DoctorRegistrationController());
  final localStorage = GetStorage();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DoctorRegistrationView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              controller: dName,
              decoration: InputDecoration(labelText: "Doctor Name"),
            ),
            TextField(
              controller: dDescription,
              decoration: InputDecoration(labelText: "Doctor Description"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => doctorController.registerDoctor(
                dName.text, 
                dDescription.text, 
                localStorage.read('currentUserId')), 
              child: Text("Register Doctor"))
          ],
        ),
      )
    );
  }
}
