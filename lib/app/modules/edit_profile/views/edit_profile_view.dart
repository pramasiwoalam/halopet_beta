import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/medical_list_reg/controllers/medical_list_reg_controller.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../../service_list/controllers/service_list_controller.dart';
import '../controllers/edit_profile_controller.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class EditProfileView extends GetView<EditProfileController> {
  Map<String, dynamic> formData = {
    'name': null,
    'phone': null,
    'address': null,
    'city': null,
    'postalCode': null
  };

  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var localStorage = GetStorage();
    Map<String, dynamic> userData = localStorage.read('userData');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
              fontFamily: 'SanFrancisco', fontSize: 15, color: Colors.white),
        ),
        backgroundColor: Color(0xffF9813A),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
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
                        height: 25,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: "Name",
                            hintText: userData['name'],
                            hintStyle: TextStyle(
                                fontFamily: 'SanFrancisco.Light',
                                fontSize: 13,
                                color: Colors.grey.shade600),
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always),
                        validator: (value) {
                          if (value!.contains('Wira')) {
                            return 'Wira Dilarang daftar';
                          }
                        },
                        onSaved: (value) {
                          if (value == null) {
                            formData['name'] = userData['name'];
                          } else {
                            formData['name'] = value;
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelText: "Phone Number",
                              hintText: userData['phone'],
                              hintStyle: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 13,
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
                            if (value == null) {
                              formData['phone'] = userData['phone'];
                            } else {
                              formData['phone'] = value;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelText: "Address*",
                              hintText: userData['address'],
                              hintStyle: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 13,
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
                            if (value == null) {
                              formData['address'] = userData['address'];
                            } else {
                              formData['address'] = value;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelText: "City",
                              hintText: userData['city'],
                              hintStyle: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 13,
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
                            if (value == null) {
                              formData['city'] = userData['city'];
                            } else {
                              formData['city'] = value;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelText: "Postal Code",
                              hintText: userData['postalCode'],
                              hintStyle: TextStyle(
                                  fontFamily: 'SanFrancisco.Light',
                                  fontSize: 13,
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
                            if (value == null) {
                              formData['postalCode'] = userData['postalCode'];
                            } else {
                              formData['postalCode'] = value;
                            }
                          },
                        ),
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
                                    'Confirmation',
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
                                      'Are you the data is correct? Confirm to update your profile.',
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
                                              color: Color(0xffF9813A)),
                                        )),
                                    TextButton(
                                        onPressed: () => {
                                              if (form.currentState!.validate())
                                                {
                                                  form.currentState!.save(),
                                                  Get.back(),
                                                  controller
                                                      .updateProfile(formData),
                                                  Get.toNamed(Routes.HOMEPAGE),
                                                }
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
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
