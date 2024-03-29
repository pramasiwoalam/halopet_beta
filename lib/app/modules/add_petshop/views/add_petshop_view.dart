import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../../service_list/controllers/service_list_controller.dart';
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
  final serviceListController = Get.put(ServiceListController());

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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Create Petshop',
          style: TextStyle(
              fontFamily: 'SanFrancisco',
              fontSize: 15,
              color: Colors.grey.shade800),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              Container(
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
                  padding: const EdgeInsets.only(
                      left: 25, bottom: 25, right: 25, top: 10),
                  child: Form(
                    key: form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              labelText: "Petshop Name *",
                              hintText: 'Name',
                              hintStyle: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.grey.shade600),
                              contentPadding: EdgeInsets.all(18),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Petshop name cannot be null.';
                            }
                          },
                          onSaved: (value) {
                            formData['name'] = value;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                labelText: "Petshop Address *",
                                hintText: 'Address',
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.grey.shade600),
                                contentPadding: EdgeInsets.all(18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Petshop address cannot be null.';
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
                                padding: const EdgeInsets.only(top: 25),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      labelText: "District *",
                                      hintText: 'District',
                                      hintStyle: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Colors.grey.shade600),
                                      contentPadding: EdgeInsets.all(18),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Petshop district cannot be null.';
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
                                padding:
                                    const EdgeInsets.only(top: 25, left: 15),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      labelText: "City *",
                                      hintText: 'City',
                                      hintStyle: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Colors.grey.shade600),
                                      contentPadding: EdgeInsets.all(18),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Petshop city cannot be null.';
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
                          padding: const EdgeInsets.only(top: 25),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                labelText: "Petshop Phone Number *",
                                hintText: 'Phone',
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.grey.shade600),
                                contentPadding: EdgeInsets.all(18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Petshop phone number cannot be null.';
                              }
                            },
                            onSaved: (value) {
                              formData['phone'] = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: TextFormField(
                            maxLines: null,
                            minLines: 2,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                labelText: "Petshop Description *",
                                hintText: 'Description',
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.grey.shade600),
                                contentPadding: EdgeInsets.all(18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Petshop description cannot be null.';
                              }
                            },
                            onSaved: (value) {
                              formData['desc'] = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
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
                                    BorderRadius.all(Radius.circular(10))),
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
                                padding: const EdgeInsets.only(top: 25),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      labelText: "Open Hours *",
                                      hintText: '07.00 am',
                                      hintStyle: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Colors.grey.shade600),
                                      contentPadding: EdgeInsets.all(18),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Petshop open hours cannot be null.';
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
                                    margin: EdgeInsets.only(top: 15),
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
                                              const Radius.circular(10))),
                                      labelText: "Open Hours *",
                                      hintText: '21.00 pm',
                                      hintStyle: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Colors.grey.shade600),
                                      contentPadding: EdgeInsets.all(18),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Petshop closed hours cannot be null.';
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
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: size.height * 0.07,
                          width: size.width * 0.9,
                          color: Colors.transparent,
                          child: ElevatedButton(
                            onPressed: () => {
                              if (form.currentState!.validate())
                                {
                                  Get.dialog(AlertDialog(
                                    title: Text(
                                      'Booking Confirmation',
                                      style: TextStyle(
                                          fontFamily: 'SanFrancisco',
                                          fontSize: 14),
                                    ),
                                    titlePadding: EdgeInsets.only(
                                        left: 26, right: 26, top: 30),
                                    contentPadding: EdgeInsets.only(
                                        left: 26,
                                        right: 26,
                                        top: 16,
                                        bottom: 12),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    content: Text(
                                        'Are you the data is correct? Confirm to create service.',
                                        style: TextStyle(
                                            fontFamily: 'SanFrancisco.Light',
                                            fontSize: 12)),
                                    actionsPadding: EdgeInsets.only(
                                        right: 12, top: 6, bottom: 2),
                                    actions: [
                                      TextButton(
                                          onPressed: () => {Get.back()},
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontFamily:
                                                    'SanFrancisco.Light',
                                                fontSize: 13,
                                                color: Color(0xffF9813A)),
                                          )),
                                      TextButton(
                                          onPressed: () => {
                                                Get.back(),
                                                form.currentState!.save(),
                                                localStorage.write(
                                                    'generalData', formData),
                                                petshopController
                                                    .createPetshop(formData),
                                                localStorage.write(
                                                    'groomingFlag', false),
                                                localStorage.write(
                                                    'hotelFlag', false),
                                                localStorage.write(
                                                    'vetFlag', false),
                                                Get.toNamed(
                                                    Routes.SERVICE_LIST),
                                              },
                                          child: Text(
                                            'Confirm',
                                            style: TextStyle(
                                                fontFamily: 'SanFrancisco',
                                                fontSize: 13,
                                                color: Color(0xffF9813A)),
                                          )),
                                    ],
                                  ))
                                },
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              primary: Color(0xffF9813A),
                              shape: StadiumBorder(),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Save",
                                      style: TextStyle(
                                        fontFamily: 'SanFrancisco',
                                        fontSize: 15,
                                        color: Colors.white,
                                      )),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
