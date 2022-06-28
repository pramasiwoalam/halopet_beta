import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../../service_list/controllers/service_list_controller.dart';
import '../controllers/edit_petshop_form_controller.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class Days {
  final int id;
  final String name;

  Days({
    required this.id,
    required this.name,
  });
}

class EditPetshopFormView extends GetView<EditPetshopFormController> {
  final petshopController = Get.put(EditPetshopFormController());
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
    Map<String, dynamic> dataMap = GetStorage().read('tempPetshopData');
    var localStorage = GetStorage();
    var petshopId = localStorage.read('tempPetshopId');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Petshop',
          style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 16),
        ),
        backgroundColor: Color(0xff2596BE),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: height / 4,
              color: Color(0xff2596BE),
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
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText: "Petshop Name *",
                            hintText: dataMap['petshopName'],
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
                                    hintText: dataMap['district'],
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
                                    hintText: dataMap['city'],
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
                              hintText: dataMap['phone'],
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
                              hintText: dataMap['desc'],
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
                                    hintText: dataMap['openHoursStart'],
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
                                    hintText: dataMap['openHoursEnd'],
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
                      SizedBox(
                        height: 20,
                      ),
                      FlatButton(
                          onPressed: () => {
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
                                      left: 26, right: 26, top: 16, bottom: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  content: Text(
                                      'Are you the data is correct? Confirm if you sure.',
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
                                              fontFamily: 'SanFrancisco.Light',
                                              fontSize: 13,
                                              color: Color(0xff2596BE)),
                                        )),
                                    TextButton(
                                        onPressed: () => {
                                              Get.back(),
                                              if (form.currentState!.validate())
                                                {
                                                  form.currentState!.save(),
                                                  localStorage.write(
                                                      'generalData', formData),
                                                  petshopController.editPetshop(
                                                      formData, petshopId),
                                                },
                                            },
                                        child: Text(
                                          'Confirm',
                                          style: TextStyle(
                                              fontFamily: 'SanFrancisco',
                                              fontSize: 13,
                                              color: Color(0xff2596BE)),
                                        )),
                                  ],
                                ))
                              },
                          child: Container(
                              height: height * 0.07,
                              width: width,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        spreadRadius: 3,
                                        blurRadius: 4,
                                        offset: Offset(0, 4))
                                  ],
                                  color: Color(0xff2596BE),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("Confirm",
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
                              ))),
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
