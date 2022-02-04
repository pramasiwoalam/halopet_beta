import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/pet_hotel_order_controller.dart';

class PetHotelOrderView extends GetView<PetHotelOrderController> {
  
  final orderController = Get.put(PetHotelOrderController());
  final typeController = TextEditingController();

  void setValue (DateTime dateTime) {
    var date = DateFormat('dd / MM / yyyy').format(dateTime);
    orderController.date.value = date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Pet Hotel'),
        centerTitle: true,
      ),
      body: 
        Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Book your order',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextField(
                controller: typeController,
                decoration: InputDecoration(labelText: "Type of pet..."),
              ),
              SizedBox(height: 10),
              Obx(() =>
                ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(2000), 
                    lastDate: DateTime(2023)
                    ).then((value) => {
                      setValue(value!)
                    });
                  }, 
                  child: orderController.date == "null" ?
                    Text("Choose Date")
                    : Text("${orderController.date}")
                ),   
              ),
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
        ),
      );
  }
}