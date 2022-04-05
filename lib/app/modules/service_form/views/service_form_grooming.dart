import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/service_form/views/detail_service_form_grooming.dart';
import 'package:halopet_beta/app/modules/service_list/controllers/service_list_controller.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/service_form_controller.dart';

class GroomingService extends StatelessWidget {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  final controller = Get.put(ServiceListController());
  final serviceController = Get.put(ServiceFormController());
  Map<String, dynamic> formData = {'name': null, 'desc': null};

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var localStorage = GetStorage();

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Form(
        key: form,
        child: Stack(
          children: [
            Container(
              height: height / 4,
              color: Color(0xffF9813A),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.015),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          labelText: "Service Name *",
                          hintText: 'Grooming',
                          hintStyle: GoogleFonts.roboto(
                              fontSize: 14, color: Colors.grey.shade600),
                          contentPadding: EdgeInsets.all(18),
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                      validator: (value) {
                        if (value!.contains('Wira')) {
                          return 'Wira Dilarang daftar';
                        }
                      },
                      onSaved: (value) {
                        formData['name'] = 'Grooming';
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          labelText: "Service Description *",
                          hintStyle: GoogleFonts.roboto(
                              fontSize: 14, color: Colors.grey.shade600),
                          hintText: 'Description',
                          contentPadding: EdgeInsets.all(18),
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                      validator: (value) {
                        if (value!.contains('Wira')) {
                          return 'Wira dilarang daftar';
                        }
                      },
                      onSaved: (value) {
                        formData['desc'] = value;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      '    Register Package(s) *',
                      style: GoogleFonts.roboto(
                          fontSize: 14, color: Colors.grey.shade700),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    serviceController.packageList.isEmpty
                        ? InkWell(
                            onTap: () => {
                              Get.toNamed(Routes.SERVICE_LIST),
                              Get.toNamed(Routes.SERVICE_FORM,
                                  arguments: 'detailGrooming')
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              height: height * 0.06,
                              width: width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: Offset(0, 3))
                                  ]),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_rounded,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Add Package',
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.grey.shade700),
                                  )
                                ],
                              )),
                            ),
                          )
                        : ListView.builder(
                            itemCount: serviceController.packageList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () =>
                                    print(serviceController.packageList),
                                child: Container(
                                  margin: EdgeInsets.only(left: 15, right: 15),
                                  height: height * 0.06,
                                  width: width * 0.8,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade300,
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0, 3))
                                      ]),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_rounded,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        serviceController.packageList[index]
                                            ['name'],
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.grey.shade700),
                                      )
                                    ],
                                  )),
                                ),
                              );
                            }),
                    ElevatedButton(
                        onPressed: () async {
                          if (form.currentState!.validate() &&
                              serviceController.packageList.isNotEmpty) {
                            form.currentState!.save();

                            controller.createPetshop(formData);
                            localStorage.write('grooming', true);
                            Get.toNamed(Routes.SERVICE_LIST);
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.WARNING,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Package is Empty.',
                              desc:
                                  'Please fill the package(s) before you register.',
                              btnOkColor: Color(0xffF9813A),
                              btnOkText: 'Ok',
                              btnOkOnPress: () => {},
                              buttonsTextStyle: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600),
                            ).show();
                          }
                        },
                        child: Text('Register')),
                    ElevatedButton(
                        onPressed: () => {
                              Get.toNamed(Routes.SERVICE_LIST),
                              controller.cancellation(
                                  localStorage.read('savedPetshopId'),
                                  localStorage.read('savedServiceId'))
                            },
                        child: Text('Back To Service List'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
