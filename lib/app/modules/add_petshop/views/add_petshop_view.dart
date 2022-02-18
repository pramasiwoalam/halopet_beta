import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/add_petshop_controller.dart';

class AddPetshopView extends GetView<AddPetshopController> {
  final pName = TextEditingController();
  final pAddress = TextEditingController();
  final pDesc = TextEditingController();
  final groomingPrice = TextEditingController();
  final groomingType = TextEditingController();
  final hotelPrice = TextEditingController();
  final hotelType = TextEditingController();
  final petshopController = Get.put(AddPetshopController());

  Map<String, dynamic> formData = {'name': null, 'address': null, 'desc': null};

  @override
  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('AddPetshopView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: form,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: "Petshop Name *",
                      hintText: 'Name',
                      contentPadding: EdgeInsets.all(18),
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                  // textInputAction: TextInputAction.done,
                  controller: pName,
                  validator: (String? value) {
                    if (pName.text.contains('@')) {
                      return 'Error';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (String value) {
                    formData['name'] = pName;
                  },
                  onSaved: (String? value) {
                    formData['name'] = pName;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: "Petshop Address *",
                        hintText: 'Address',
                        contentPadding: EdgeInsets.all(18),
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                    controller: pAddress,
                    validator: (String? value) {
                      if (value!.contains('@')) {
                        return 'Error 2';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (String value) {
                      formData['address'] = value;
                    },
                    onSaved: (String? value) {
                      formData['address'] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextFormField(
                    maxLines: null,
                    minLines: 4,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: "Petshop Description *",
                        hintText: 'Description',
                        contentPadding: EdgeInsets.all(18),
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                    controller: pDesc,
                    validator: (String? value) {
                      if (value!.contains('@')) {
                        return 'Error 2';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (String value) {
                      formData['desc'] = value;
                    },
                    onSaved: (String? value) {
                      formData['desc'] = value;
                    },
                  ),
                ),
                Text("List of Services: "),
                Obx(
                  () => CheckboxListTile(
                      title: Text("Pet Grooming Service"),
                      value: petshopController.checkValue1.value,
                      onChanged: (value) {
                        petshopController.checkValue1.value =
                            !petshopController.checkValue1.value;
                      }),
                ),
                Obx(() => petshopController.checkValue1.value == true
                    ? Column(
                        children: [
                          TextField(
                            controller: groomingPrice,
                            decoration: InputDecoration(
                                labelText: "Grooming price range"),
                          ),
                          TextField(
                            controller: groomingType,
                            decoration:
                                InputDecoration(labelText: "Grooming pet type"),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 1,
                      )),
                Obx(
                  () => CheckboxListTile(
                      title: Text("Pet Hotel Service"),
                      value: petshopController.checkValue2.value,
                      onChanged: (value) {
                        petshopController.checkValue2.value =
                            !petshopController.checkValue2.value;
                      }),
                ),
                Obx(() => petshopController.checkValue2.value == true
                    ? Column(
                        children: [
                          TextField(
                            controller: hotelPrice,
                            decoration: InputDecoration(
                                labelText: "Pet hotel price / room"),
                          ),
                          TextField(
                            controller: hotelType,
                            decoration: InputDecoration(labelText: "Pet type"),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 1,
                      )),
                Obx(
                  () => CheckboxListTile(
                      title: Text("Vet Available"),
                      value: petshopController.checkValue3.value,
                      onChanged: (value) {
                        petshopController.checkValue3.value =
                            !petshopController.checkValue3.value;
                      }),
                ),
                Obx(() => petshopController.checkValue3.value == true
                    ? Column(
                        children: [
                          Text(
                              "You don't have any doctors registered, please register"),
                          ElevatedButton(
                              onPressed: () =>
                                  Get.toNamed(Routes.DOCTOR_REGISTRATION),
                              child: Text("Register the doctor"))
                        ],
                      )
                    : SizedBox(
                        height: 1,
                      )),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (form.currentState!.validate()) {
                        form.currentState!.save();
                      }
                    },
                    // petshopController.createPetshop(
                    //     pName.text,
                    //     pAddress.text,
                    //     groomingPrice.text,
                    //     groomingType.text,
                    //     int.parse(hotelPrice.text),
                    //     hotelType.text,
                    //     petshopController.checkValue1.value,
                    //     petshopController.checkValue2.value,
                    //     petshopController.checkValue3.value),
                    child: Text("Create Petshop"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
