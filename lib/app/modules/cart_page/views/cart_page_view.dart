import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halopet_beta/app/modules/petshop_detail/controllers/petshop_detail_controller.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';

import '../controllers/cart_page_controller.dart';

class CartPageView extends GetView<CartPageController> {
  var localStorage = GetStorage();
  final detailC = Get.put(PetshopDetailController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var orderList = detailC.orderList;
    var totalPrice = 0;

    void delete(int i) {
      int indexPrice = detailC.orderList[i]['price'];
      totalPrice = totalPrice - indexPrice;
      detailC.orderList.removeAt(i);
      print(controller.totalPrice);
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('CartPageView'),
            centerTitle: true,
          ),
          body: Obx(
            () => Container(
              height: height,
              width: width,
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderList.length,
                      itemBuilder: (context, index) {
                        totalPrice += (orderList[index]!['price'] as int);
                        controller.totalPrice = totalPrice.obs;
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            width: width,
                            height: height * 0.15,
                            // color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Text(
                                    '${orderList[index]['serviceName']}',
                                    style: GoogleFonts.roboto(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '${orderList[index]['price']}',
                                    style: GoogleFonts.roboto(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.INFO,
                                          animType: AnimType.BOTTOMSLIDE,
                                          title: 'Order Cancellation',
                                          desc:
                                              'Are you sure want to cancel this order?',
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () {
                                            delete(index);
                                            Get.toNamed(Routes.PETSHOP_DETAIL,
                                                arguments: localStorage
                                                    .read('petshopId'));
                                          },
                                        ).show();
                                      },
                                      child: Icon(Icons.delete))
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  Text('${controller.totalPrice.value}'),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.PETSHOP_DETAIL,
                            arguments: localStorage.read('petshopId'));
                      },
                      child: Text('make another')),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.HOMEPAGE,
                            arguments: localStorage.read('petshopId'));
                      },
                      child: Text('Cancel & back to main page')),
                  ElevatedButton(onPressed: () {}, child: Text('Order'))
                ],
              ),
            ),
          )),
    );
  }
}
