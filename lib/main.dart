import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halopet_beta/app/controllers/auth_controller.dart';
import 'package:halopet_beta/app/modules/admin_home/views/admin_home_view.dart';
import 'package:halopet_beta/app/modules/homepage/views/homepage_view.dart';
import 'package:halopet_beta/app/modules/login/views/login_view.dart';
// import 'package:halopet_beta/app/modules/login/views/login_view.dart';
import 'package:halopet_beta/app/modules/seller_home/views/seller_home_view.dart';
import 'package:halopet_beta/app/modules/welcome_page/views/welcome_page_view.dart';
import 'package:halopet_beta/app/routes/app_pages.dart';
import 'package:halopet_beta/app/routes/auth_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: authC.streamUser,
        builder: (context, snapshot) {
          localStorage.write('currentUserId', snapshot.data?.uid);
          // var userId = localStorage.read('currentUserId');
          if (snapshot.connectionState == ConnectionState.active) {
            return GetMaterialApp(
              home: snapshot.data != null
                  // && userId != null
                  ?
                  // WelcomePageView()
                  StreamBuilder<Object>(
                      stream: authC.streamRole(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          final user = snapshot.data as DocumentSnapshot;
                          if (user['petshopOwner'] == true) {
                            localStorage.write(
                                'initialPetshopId', user['petshopId']);
                          }
                          if (user['role'] == 'Admin') {
                            return AdminHomeView();
                          } else if (user['role'] == 'Member') {
                            return HomepageView();
                          } else if (user['role'] == 'Seller') {
                            return SellerHomeView();
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        } else {
                          return LoginView();
                        }
                      })
                  : LoginView(),
              getPages:
                  snapshot.data != null ? AppPages.routes : AuthPages.routes,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
