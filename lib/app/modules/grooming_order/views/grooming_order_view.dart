import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';
import 'package:intl/intl.dart';

import '../controllers/grooming_order_controller.dart';

class GroomingOrderView extends GetView<GroomingOrderController> {
  final orderController = Get.put(GroomingOrderController());
  final typeController = TextEditingController();

  void setValue(DateTime dateTime) {
    var date = DateFormat('MMMM dd, yyyy').format(dateTime);
    orderController.date.value = date;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var petId = localStorage.read('petId');
    DateFormat format = new DateFormat("MMMM dd, yyyy");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book a service',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        backgroundColor: Color(0xffF9813A),
        elevation: 0,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getPets(petId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var dataMap = snapshot.data!.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: size.height * 0.065,
                          width: width * 0.43,
                          child: TextField(
                            readOnly: true,
                            // controller: emailController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(16),
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              hintText: dataMap['name'],
                              labelText: 'Pet Name',
                              hintStyle: GoogleFonts.roboto(
                                  color: Colors.grey.shade600, fontSize: 14),
                              border: InputBorder.none,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: size.height * 0.065,
                          width: width * 0.43,
                          child: TextField(
                            readOnly: true,
                            // controller: emailController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(16),
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              hintText: "Pet's parent name",
                              labelText: 'Pet Owner Name',
                              hintStyle: GoogleFonts.roboto(
                                  color: Colors.grey.shade600, fontSize: 14),
                              border: InputBorder.none,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: size.height * 0.065,
                      width: width,
                      child: TextField(
                        readOnly: true,
                        // controller: emailController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade400, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade400, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            hintText: dataMap['species'],
                            labelText: 'Pet Breeds',
                            hintStyle: GoogleFonts.roboto(
                                color: Colors.grey.shade600, fontSize: 14),
                            border: InputBorder.none,
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: size.height * 0.065,
                          width: width * 0.28,
                          child: TextField(
                            readOnly: true,
                            // controller: emailController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(16),
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                hintText: '${dataMap['age']} month(s).',
                                labelText: 'Age',
                                hintStyle: GoogleFonts.roboto(
                                    color: Colors.grey.shade600, fontSize: 14),
                                border: InputBorder.none,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: size.height * 0.065,
                          width: width * 0.28,
                          child: TextField(
                            readOnly: true,
                            // controller: emailController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(16),
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                hintText: '${dataMap['weight']} kg(s).',
                                labelText: 'Weight',
                                hintStyle: GoogleFonts.roboto(
                                    color: Colors.grey.shade600, fontSize: 14),
                                border: InputBorder.none,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                          ),
                        ),
                        Container(
                          height: size.height * 0.065,
                          width: width * 0.28,
                          child: TextField(
                            readOnly: true,
                            // controller: emailController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(16),
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                hintText: dataMap['gender'],
                                labelText: 'Gender',
                                hintStyle: GoogleFonts.roboto(
                                    color: Colors.grey.shade600, fontSize: 14),
                                border: InputBorder.none,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => Container(
                        height: height * 0.07,
                        width: width,
                        child: FlatButton(
                          color: orderController.date == 'null'
                              ? Colors.white
                              : Colors.blue,
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2023))
                                .then((value) => {setValue(value!)});
                          },
                          child: orderController.date == "null"
                              ? Text(
                                  "Choose Booking Date *",
                                  style: GoogleFonts.roboto(
                                      color: Colors.grey.shade700,
                                      fontSize: 15),
                                )
                              : Text(
                                  'Booking Date: ${controller.date}',
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                          textColor: Colors.grey.shade600,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: orderController.date == 'null'
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade100,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Choose Grooming Package'),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () => {},
                        child: Text('Package A ------- Rp. 500.000')),
                    ElevatedButton(
                        onPressed: () => {},
                        child: Text('Package B ------- Rp. 400.000')),
                    ElevatedButton(
                        onPressed: () => {},
                        child: Text('Package C ------- Rp. 200.000')),
                    // Obx(
                    //   () => InkWell(
                    //     onTap: () {
                    //       showDatePicker(
                    //               context: context,
                    //               initialDate: DateTime.now(),
                    //               firstDate: DateTime.now(),
                    //               lastDate: DateTime(2023))
                    //           .then((value) => {setValue(value!)});
                    //     },
                    //     child: Container(
                    //       height: size.height * 0.065,
                    //       width: width * 0.28,
                    //       child: TextField(
                    //         enabled: false,
                    //         decoration: InputDecoration(
                    //           contentPadding: EdgeInsets.all(16),
                    //           isDense: true,
                    //           enabledBorder: OutlineInputBorder(
                    //               borderSide:
                    //                   BorderSide(color: Colors.grey.shade400, width: 1),
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(20.0))),
                    //           focusedBorder: OutlineInputBorder(
                    //               borderSide:
                    //                   BorderSide(color: Colors.grey.shade400, width: 1),
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(20.0))),
                    //           hintText: orderController.date == "null"
                    //               ? "Choose Date"
                    //               : "${orderController.date}",
                    //           hintStyle: GoogleFonts.roboto(
                    //               color: Colors.grey.shade600, fontSize: 12),
                    //           border: InputBorder.none,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Obx(
                    //   () => ElevatedButton(
                    //       onPressed: () {
                    //         showDatePicker(
                    //                 context: context,
                    //                 initialDate: DateTime.now(),
                    //                 firstDate: DateTime.now(),
                    //                 lastDate: DateTime(2023))
                    //             .then((value) => {setValue(value!)});
                    //       },
                    //       child: orderController.date == "null"
                    //           ? Text("Choose Date")
                    //           : Text("${orderController.date}")),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () => orderController.createOrder(
                            typeController.text,
                            orderController.date.toString()),
                        child: Text("Request Booking"))
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
