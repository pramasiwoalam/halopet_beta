import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: size.height * 0.065,
                  width: width * 0.43,
                  child: TextField(
                    // controller: emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      hintText: "Pet's name",
                      hintStyle: GoogleFonts.roboto(
                          color: Colors.grey.shade600, fontSize: 12),
                      border: InputBorder.none,
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
                    // controller: emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      hintText: "Pet's parent name",
                      hintStyle: GoogleFonts.roboto(
                          color: Colors.grey.shade600, fontSize: 12),
                      border: InputBorder.none,
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
                // controller: emailController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  hintText: "Pet's breeds (ex: Dog: Husky)",
                  hintStyle: GoogleFonts.roboto(
                      color: Colors.grey.shade600, fontSize: 12),
                  border: InputBorder.none,
                ),
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
                    // controller: emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      hintText: "Age",
                      hintStyle: GoogleFonts.roboto(
                          color: Colors.grey.shade600, fontSize: 12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.065,
                  width: width * 0.28,
                  child: TextField(
                    // controller: emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      hintText: "Weight",
                      hintStyle: GoogleFonts.roboto(
                          color: Colors.grey.shade600, fontSize: 12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.065,
                  width: width * 0.28,
                  child: TextField(
                    // controller: emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      hintText: "Gender",
                      hintStyle: GoogleFonts.roboto(
                          color: Colors.grey.shade600, fontSize: 12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Obx(
              () => Container(
                height: height * 0.065,
                width: width,
                child: FlatButton(
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
                          "Choose Date",
                          style: GoogleFonts.roboto(
                              color: Colors.grey.shade600, fontSize: 12),
                        )
                      : Text(
                          '${controller.date}',
                          style: GoogleFonts.roboto(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                  textColor: Colors.grey.shade600,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
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
                    typeController.text, orderController.date.toString()),
                child: Text("Request Booking"))
          ],
        ),
      ),
    );
  }
}
