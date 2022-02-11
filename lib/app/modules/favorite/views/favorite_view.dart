import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('FavoriteView'),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot<Object?>>(
            stream: controller.getPetshopByFavId(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var data = snapshot.data!.docs;

                return Container(
                  height: height,
                  width: width,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            height: height * 0.2,
                            width: width,
                            // color: Colors.black,
                            child: Column(
                              children: [
                                Text(
                                    '${(data[index].data() as Map<String, dynamic>)['petshopName']}'),
                                Text(
                                    '${(data[index].data() as Map<String, dynamic>)['petshopAddress']}')
                              ],
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
