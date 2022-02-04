import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:halopet_beta/app/modules/homepage/bindings/homepage_binding.dart';
import 'package:halopet_beta/app/modules/homepage/views/homepage_view.dart';
import 'package:halopet_beta/app/modules/login/bindings/login_binding.dart';
import 'package:halopet_beta/app/modules/login/views/login_view.dart';
import 'package:halopet_beta/app/modules/signup/bindings/signup_binding.dart';
import 'package:halopet_beta/app/modules/signup/views/signup_view.dart';
import 'package:halopet_beta/app/modules/welcome_page/bindings/welcome_page_binding.dart';
import 'package:halopet_beta/app/modules/welcome_page/views/welcome_page_view.dart';

part 'auth_routes.dart';

class AuthPages {
  AuthPages._();

  // static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOMEPAGE,
      page: () => HomepageView(),
      binding: HomepageBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME_PAGE,
      page: () => WelcomePageView(),
      binding: WelcomePageBinding(),
    ),
  ];
}
