import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/petshop_detail/views/petshop_detail_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../delivery_list/controllers/delivery_list_controller.dart';
import '../controllers/grooming_order_controller.dart';

class VetOrderView extends GetView<GroomingOrderController> {
  final orderController = Get.put(GroomingOrderController());
  final typeController = TextEditingController();
  final deliveryController = Get.put(DeliveryListController());

  void setValue(DateTime dateTime) {
    var date = DateFormat('MMMM dd, yyyy').format(dateTime);
    orderController.date.value = date;
  }

  Map<String, dynamic> formData = {
    'symptoms': "Abdomen",
  };

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var petId = localStorage.read('petId');
    DateFormat format = new DateFormat("MMMM dd, yyyy");
    print(localStorage.read('deliveryCharge'));

    void getTime(TimeOfDay time) {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');
      controller.time.value = "Pick Up Time: ${hours}:${minutes}";
    }

    double bookingFee = 5000;
    double charge = 0;
    if (localStorage.read('deliveryCharge') == null) {
      charge = bookingFee;
    } else {
      charge = bookingFee + localStorage.read('deliveryCharge');
    }

    localStorage.write('totalCharge', charge);
    MoneyFormatter fmf = MoneyFormatter(
        amount: charge,
        settings: MoneyFormatterSettings(
          symbol: 'Rp.',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
        ));
    MoneyFormatterOutput fo = fmf.output;

    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.getPets(petId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var dataMap = snapshot.data!.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: size.height * 0.065,
                            width: width * 0.43,
                            child: TextField(
                              readOnly: true,
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
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
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
                                          color: Colors.grey.shade400,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  hintText: '${dataMap['age']} month(s).',
                                  labelText: 'Age',
                                  hintStyle: GoogleFonts.roboto(
                                      color: Colors.grey.shade600,
                                      fontSize: 14),
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
                                          color: Colors.grey.shade400,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  hintText: '${dataMap['weight']} kg(s).',
                                  labelText: 'Weight',
                                  hintStyle: GoogleFonts.roboto(
                                      color: Colors.grey.shade600,
                                      fontSize: 14),
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
                                          color: Colors.grey.shade400,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  hintText: dataMap['gender'],
                                  labelText: 'Gender',
                                  hintStyle: GoogleFonts.roboto(
                                      color: Colors.grey.shade600,
                                      fontSize: 14),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          maxLines: null,
                          minLines: 4,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              labelText: "Pet Symptoms*",
                              hintText: 'Abdomen, Swollen',
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
                            formData['symptoms'] = value;
                          },
                        ),
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
                                : Color(0xffF9813A),
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
                      Obx(
                        () => Container(
                          height: height * 0.07,
                          width: width,
                          child: FlatButton(
                            color: orderController.vetFlag == 'null'
                                ? Colors.white
                                : Color(0xffF9813A),
                            onPressed: () =>
                                {Get.toNamed(Routes.CHOOSE_SESSION)},
                            child: orderController.vetFlag == "null"
                                ? Text(
                                    "Choose Vet Session *",
                                    style: GoogleFonts.roboto(
                                        color: Colors.grey.shade700,
                                        fontSize: 15),
                                  )
                                : Text(
                                    'Vet Session: ${localStorage.read('vetSession')}',
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: orderController.vetFlag == 'null'
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Order with delivery?',
                                style: GoogleFonts.roboto(
                                    color: Colors.grey.shade800,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              width: width * 0.3,
                              height: height * 0.045,
                              child: ToggleSwitch(
                                minWidth: width * 0.148,
                                cornerRadius: 20.0,
                                activeBgColors: [
                                  [Colors.red],
                                  [Colors.green]
                                ],
                                activeFgColor: Colors.white,
                                inactiveBgColor: Colors.grey.shade300,
                                inactiveFgColor: Colors.white,
                                initialLabelIndex: 0,
                                totalSwitches: 2,
                                labels: ['No', 'Yes'],
                                radiusStyle: true,
                                onToggle: (index) {
                                  controller.status = index.toString();
                                  print(controller.status);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Obx(() => orderController.vetFlag == 'null'
                          ? SizedBox()
                          : Container(
                              height: height * 0.15,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: Offset(0, 2))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(26),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Booking Fee',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: Colors.grey.shade500)),
                                        Text("Rp. $bookingFee",
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: Colors.grey.shade500)),
                                      ],
                                    ),
                                    Spacer(),
                                    localStorage.read('deliveryCharge') == null
                                        ? SizedBox()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Delivery Charge',
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15,
                                                      color: Colors
                                                          .grey.shade500)),
                                              Text(
                                                  "Rp. ${localStorage.read('deliveryCharge')}",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15,
                                                      color: Colors
                                                          .grey.shade500)),
                                            ],
                                          ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Total Charge',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 15,
                                                color: Colors.grey.shade500)),
                                        Text(fo.symbolOnLeft,
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 15,
                                                color: Color(0xffF9813A))),
                                      ],
                                    ),
                                  ],
                                ),
                              ))),

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
                      FlatButton(
                          onPressed: () => {
                                if (controller.status == '0')
                                  {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Booking Confirmation',
                                      desc:
                                          'Are you sure want to create this booking?.',
                                      btnCancelOnPress: () => {},
                                      btnOkText: 'Yes',
                                      buttonsTextStyle: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w600),
                                      btnOkOnPress: () {
                                        deliveryController.deliveryFee == 0
                                            ? orderController.createVetOrder(
                                                typeController.text,
                                                orderController.date.toString(),
                                                "Vet",
                                                formData['symptoms'],
                                                localStorage
                                                    .read('totalCharge'),
                                                controller
                                                    .appointmentTime.value)
                                            : orderController
                                                .createVetOrderWithDelivery(
                                                    petId,
                                                    orderController.date
                                                        .toString(),
                                                    localStorage
                                                        .read('serviceType'),
                                                    formData['symptoms'],
                                                    localStorage
                                                        .read('totalCharge'),
                                                    controller
                                                        .appointmentTime.value,
                                                    deliveryController.time
                                                        .toString(),
                                                    deliveryController
                                                        .deliveryFee);

                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.SUCCES,
                                          animType: AnimType.BOTTOMSLIDE,
                                          title: 'Booking Created.',
                                          desc:
                                              'You can check your order here.',
                                          btnOkText: 'Check your order >',
                                          buttonsTextStyle: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w600),
                                          btnOkOnPress: () {
                                            Get.toNamed(Routes.ORDER);
                                          },
                                        ).show();
                                      },
                                    ).show()
                                  }
                                else
                                  {Get.toNamed(Routes.DELIVERY_LIST)}
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
                                  color: Color(0xffF9813A),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: const Center(
                                  child: Text("Request Booking",
                                      style: TextStyle(
                                        fontFamily: 'SanFrancisco',
                                        fontSize: 16,
                                        color: Colors.white,
                                      )))))
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
