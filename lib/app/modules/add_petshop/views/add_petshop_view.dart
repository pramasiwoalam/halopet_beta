import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/add_petshop_controller.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class Days {
  final int id;
  final String name;

  Days({
    required this.id,
    required this.name,
  });
}

class AddPetshopView extends GetView<AddPetshopController> {
  final petshopController = Get.put(AddPetshopController());

  Map<String, dynamic> formData = {
    'name': null,
    'address': null,
    'desc': null,
    'district': null,
    'city': null,
    'phone': null,
    'value1': false,
    'value2': false,
    'value3': false,
    'dayOpen': null,
    'openHoursStart': null,
    'openHoursEnd': null
  };

  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var localStorage = GetStorage();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Petshop',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        backgroundColor: Color(0xffF9813A),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
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
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                        ],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText: "Petshop Name *",
                            hintText: 'Name',
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 14, color: Colors.grey.shade600),
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
                        padding: EdgeInsets.only(top: 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              labelText: "Petshop Address *",
                              hintText: 'Address',
                              hintStyle: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.grey.shade600),
                              contentPadding: EdgeInsets.all(18),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                          validator: (value) {
                            if (value!.contains('@')) {
                              return 'Error 2';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            formData['address'] = value;
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    labelText: "District *",
                                    hintText: 'District',
                                    hintStyle: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.grey.shade600),
                                    contentPadding: EdgeInsets.all(18),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always),
                                validator: (value) {
                                  if (value!.contains('@')) {
                                    return 'Error 2';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  formData['district'] = value;
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15, left: 15),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    labelText: "City *",
                                    hintText: 'City',
                                    hintStyle: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.grey.shade600),
                                    contentPadding: EdgeInsets.all(18),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always),
                                validator: (value) {
                                  if (value!.contains('@')) {
                                    return 'Error 2';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  formData['city'] = value;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              labelText: "Petshop Phone Number *",
                              hintText: 'Phone',
                              hintStyle: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.grey.shade600),
                              contentPadding: EdgeInsets.all(18),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                          validator: (value) {
                            if (value!.contains('@')) {
                              return 'Error 2';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            formData['phone'] = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          maxLines: null,
                          minLines: 2,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              labelText: "Petshop Description *",
                              hintText: 'Description',
                              hintStyle: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.grey.shade600),
                              contentPadding: EdgeInsets.all(18),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                          validator: (value) {
                            if (value!.contains('@')) {
                              return 'Error 2';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            formData['desc'] = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: MultiSelectFormField(
                          chipBackGroundColor: Color(0xffF9813A),
                          chipLabelStyle: GoogleFonts.roboto(
                              fontSize: 14, color: Colors.white),
                          dialogTextStyle: GoogleFonts.roboto(
                              fontWeight: FontWeight.w300, fontSize: 15),
                          checkBoxActiveColor: Color(0xffF9813A),
                          dialogShapeBorder: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          title: Text(
                            "Choose Open Day(s) *",
                            style: GoogleFonts.roboto(
                                fontSize: 14, color: Colors.grey.shade600),
                          ),
                          trailing: Icon(Icons.delete),
                          dataSource: const [
                            {
                              "display": "Monday",
                              "value": "Monday",
                            },
                            {
                              "display": "Tuesday",
                              "value": "Tuesday",
                            },
                            {
                              "display": "Wednesday",
                              "value": "Wednesday",
                            },
                            {
                              "display": "Thursday",
                              "value": "Thursday",
                            },
                            {
                              "display": "Friday",
                              "value": "Friday",
                            },
                            {
                              "display": "Saturday",
                              "value": "Saturday",
                            },
                            {
                              "display": "Sunday",
                              "value": "Sunday",
                            },
                          ],
                          // validator: (value) {
                          //   if (value == null) {
                          //     return 'Please select one or more options';
                          //   }
                          //   return null;
                          // },
                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'Choose',
                          cancelButtonLabel: 'Cancel',
                          initialValue: formData['dayOpen'],
                          onSaved: (value) {
                            if (value == null) return;
                            formData['dayOpen'] = value;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    labelText: "Open Hours *",
                                    hintText: '07.00 am',
                                    hintStyle: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.grey.shade600),
                                    contentPadding: EdgeInsets.all(18),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always),
                                validator: (value) {
                                  if (value!.contains('@')) {
                                    return 'Error 2';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  formData['openHoursStart'] = value;
                                },
                              ),
                            ),
                          ),
                          Flexible(
                              child: Container(
                                  width: width * 0.1,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Center(
                                      child: Text(
                                    'until',
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.grey.shade600),
                                  )))),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            const Radius.circular(20))),
                                    labelText: "Open Hours *",
                                    hintText: '21.00 pm',
                                    hintStyle: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.grey.shade600),
                                    contentPadding: EdgeInsets.all(18),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always),
                                validator: (value) {
                                  if (value!.contains('@')) {
                                    return 'Error 2';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  formData['openHoursEnd'] = value;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Text("List of Services: "),
                      // Obx(
                      //   () => CheckboxListTile(
                      //       title: Text("Pet Grooming Service"),
                      //       value: petshopController.checkValue1.value,
                      //       onChanged: (value) {
                      //         petshopController.checkValue1.value =
                      //             !petshopController.checkValue1.value;
                      //         formData['value1'] =
                      //             !petshopController.checkValue1.value;
                      //       }),
                      // ),
                      // Obx(() => petshopController.checkValue1.value == true
                      //     ? Column(
                      //         children: [
                      //           Padding(
                      //             padding: const EdgeInsets.only(top: 15),
                      //             child: TextFormField(
                      //               decoration: const InputDecoration(
                      //                   border: OutlineInputBorder(
                      //                       borderRadius: BorderRadius.all(
                      //                           Radius.circular(20))),
                      //                   labelText: "Grooming Price Range *",
                      //                   hintText: 'Price Range',
                      //                   contentPadding: EdgeInsets.all(18),
                      //                   floatingLabelBehavior:
                      //                       FloatingLabelBehavior.always),
                      //               validator: (value) {
                      //                 if (value!.contains('@')) {
                      //                   return 'Error 2';
                      //                 } else {
                      //                   return null;
                      //                 }
                      //               },
                      //               onSaved: (value) {
                      //                 formData['grType'] = value;
                      //               },
                      //             ),
                      //           ),
                      //           const TextField(
                      //             decoration:
                      //                 InputDecoration(labelText: "Grooming pet type"),
                      //           ),
                      //         ],
                      //       )
                      //     : const SizedBox(
                      //         height: 1,
                      //       )),
                      // Obx(
                      //   () => CheckboxListTile(
                      //       title: Text("Pet Hotel Service"),
                      //       value: petshopController.checkValue2.value,
                      //       onChanged: (value) {
                      //         petshopController.checkValue2.value =
                      //             !petshopController.checkValue2.value;
                      //         formData['value2'] =
                      //             !petshopController.checkValue2.value;
                      //       }),
                      // ),
                      // Obx(() => petshopController.checkValue2.value == true
                      //     ? Column(
                      //         children: const [
                      //           TextField(
                      //             decoration: InputDecoration(
                      //                 labelText: "Pet hotel price / room"),
                      //           ),
                      //           TextField(
                      //             decoration: InputDecoration(labelText: "Pet type"),
                      //           ),
                      //         ],
                      //       )
                      //     : const SizedBox(
                      //         height: 1,
                      //       )),
                      // Obx(
                      //   () => CheckboxListTile(
                      //       title: Text("Vet Available"),
                      //       value: petshopController.checkValue3.value,
                      //       onChanged: (value) {
                      //         petshopController.checkValue3.value =
                      //             !petshopController.checkValue3.value;
                      //         formData['value3'] =
                      //             !petshopController.checkValue3.value;
                      //       }),
                      // ),
                      // Obx(() => petshopController.checkValue3.value == true
                      //     ? Column(
                      //         children: [
                      //           const Text(
                      //               "You don't have any doctors registered, please register"),
                      //           ElevatedButton(
                      //               onPressed: () =>
                      //                   Get.toNamed(Routes.DOCTOR_REGISTRATION),
                      //               child: const Text("Register the doctor"))
                      //         ],
                      //       )
                      //     : const SizedBox(
                      //         height: 1,
                      //       )),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: FlatButton(
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.grey.shade200,
                          height: height * 0.08,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Text(
                                  "Create Service",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade800,
                                      fontSize: 15),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 21,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                          onPressed: () => {
                            // if (form.currentState!.validate()) {
                            //   form.currentState!.save();
                            //   petshopController.createPetshop(formData);
                            //
                            // }
                            localStorage.write('grooming', false),
                            localStorage.write('hotel', false),
                            localStorage.write('vet', false),
                            Get.toNamed(Routes.SERVICE_LIST)
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
