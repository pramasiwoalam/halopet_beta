import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/add_petshop_controller.dart';

class AddPetshopView extends GetView<AddPetshopController> {

  final pName = TextEditingController(); 
  final pAddress = TextEditingController();
  final groomingPrice = TextEditingController(); 
  final groomingType = TextEditingController();
  final hotelPrice = TextEditingController(); 
  final hotelType = TextEditingController();
  final petshopController = Get.put(AddPetshopController());
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('AddPetshopView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: pName,
                decoration: InputDecoration(labelText: "Petshop Name"),
              ),
              TextField(
                controller: pAddress,
                decoration: InputDecoration(labelText: "Petshop Address"),
              ),
              SizedBox(
                height: 20,
              ),
              Text("List of Services: "),
              
              Obx(() =>
                CheckboxListTile(
                  title: Text("Pet Grooming Service"),
                  value: petshopController.checkValue1.value, 
                  onChanged: (value) {
                    petshopController.checkValue1.value = !petshopController.checkValue1.value;
                  }
                ),
              ),
              Obx(() =>
              petshopController.checkValue1.value == true ? 
              Column(
                children: [
                  TextField(
                    controller: groomingPrice,
                    decoration: InputDecoration(labelText: "Grooming price range"),
                  ),
                  TextField(
                    controller: groomingType,
                    decoration: InputDecoration(labelText: "Grooming pet type"),
                  ),
                ],
              )
              : SizedBox(height: 1,)
              ),
              Obx(() =>
                CheckboxListTile(
                  title: Text("Pet Hotel Service"),
                  value: petshopController.checkValue2.value, 
                  onChanged: (value) {
                    petshopController.checkValue2.value = !petshopController.checkValue2.value;
                  }
                ),
              ),
              Obx(() =>
              petshopController.checkValue2.value == true ? 
              Column(
                children: [
                  TextField(
                    controller: hotelPrice,
                    decoration: InputDecoration(labelText: "Pet hotel price / room"),
                  ),
                  TextField(
                    controller: hotelType,
                    decoration: InputDecoration(labelText: "Pet type"),
                  ),
                ],
              )
              : SizedBox(height: 1,)
              ),
             
              Obx(() =>
                CheckboxListTile(
                  title: Text("Vet Available"),
                  value: petshopController.checkValue3.value, 
                  onChanged: (value) {
                    petshopController.checkValue3.value = !petshopController.checkValue3.value;
                  }
                ),
              ),
              Obx(() =>
              petshopController.checkValue3.value == true ? 
              Column(
                children: [
                  Text("You don't have any doctors registered, please register"),
                  ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.DOCTOR_REGISTRATION), 
                    child: Text("Register the doctor"))
                ],
              )
              : SizedBox(height: 1,)
              ),
              
              SizedBox( 
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => petshopController.createPetshop(
                  pName.text, 
                  pAddress.text,
                  groomingPrice.text,
                  groomingType.text,
                  int.parse(hotelPrice.text),
                  hotelType.text,
                  petshopController.checkValue1.value,
                  petshopController.checkValue2.value,
                  petshopController.checkValue3.value
                  ), 
                child: Text("Create Petshop"))
            ],
          ),
        ),
      ),
      
    );
  }
}
