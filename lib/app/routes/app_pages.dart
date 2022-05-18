import 'package:get/get.dart';
import 'package:halopet_beta/app/modules/package_list/bindings/package_list_binding.dart';
import 'package:halopet_beta/app/modules/package_list/views/package_list_view.dart';
import 'package:halopet_beta/app/modules/rating/bindings/rating_binding.dart';
import 'package:halopet_beta/app/modules/rating/views/rating_view.dart';
import 'package:halopet_beta/app/modules/service_form/views/service_form_view.dart';
import 'package:halopet_beta/app/modules/service_list/bindings/service_list_binding.dart';
import 'package:halopet_beta/app/modules/service_list/views/service_list_view.dart';
import 'package:halopet_beta/app/modules/topup/bindings/topup_binding.dart';
import 'package:halopet_beta/app/modules/topup/views/topup_view.dart';
import '../modules/add_petshop/bindings/add_petshop_binding.dart';
import '../modules/add_petshop/views/add_petshop_view.dart';
import '../modules/admin_home/bindings/admin_home_binding.dart';
import '../modules/admin_home/views/admin_home_view.dart';
import '../modules/admin_list_users/bindings/admin_list_users_binding.dart';
import '../modules/admin_list_users/views/admin_list_users_view.dart';
import '../modules/admin_petshop_approval/bindings/admin_petshop_approval_binding.dart';
import '../modules/admin_petshop_approval/views/admin_petshop_approval_view.dart';
import '../modules/category_page/bindings/category_page_binding.dart';
import '../modules/category_page/views/category_page_view.dart';
import '../modules/choose_pet/bindings/choose_pet_binding.dart';
import '../modules/choose_pet/views/choose_pet_view.dart';
import '../modules/doctor_registration/bindings/doctor_registration_binding.dart';
import '../modules/doctor_registration/views/doctor_registration_view.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/grooming_order/bindings/grooming_order_binding.dart';
import '../modules/grooming_order/views/grooming_order_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/history_detail/bindings/history_detail_binding.dart';
import '../modules/history_detail/views/history_detail_view.dart';
import '../modules/homepage/bindings/homepage_binding.dart';
import '../modules/homepage/views/homepage_view.dart';
import '../modules/information/bindings/information_binding.dart';
import '../modules/information/views/information_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/order_detail/bindings/order_detail_binding.dart';
import '../modules/order_detail/views/order_detail_view.dart';
import '../modules/package_form/bindings/package_form_binding.dart';
import '../modules/package_form/views/package_form_view.dart';
import '../modules/pet_form/bindings/pet_form_binding.dart';
import '../modules/pet_form/views/pet_form_view.dart';
import '../modules/pet_hotel_order/bindings/pet_hotel_order_binding.dart';
import '../modules/pet_hotel_order/views/pet_hotel_order_view.dart';
import '../modules/pet_list/bindings/pet_list_binding.dart';
import '../modules/pet_list/views/pet_list_view.dart';
import '../modules/petshop_detail/bindings/petshop_detail_binding.dart';
import '../modules/petshop_detail/views/petshop_detail_view.dart';
import '../modules/petshop_list/bindings/petshop_list_binding.dart';
import '../modules/petshop_list/views/petshop_list_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/seller_history/bindings/seller_history_binding.dart';
import '../modules/seller_history/views/seller_history_view.dart';
import '../modules/seller_home/bindings/seller_home_binding.dart';
import '../modules/seller_home/views/seller_home_view.dart';
import '../modules/seller_order_detail/bindings/seller_order_detail_binding.dart';
import '../modules/seller_order_detail/views/seller_order_detail_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/welcome_page/bindings/welcome_page_binding.dart';
import '../modules/welcome_page/views/welcome_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOMEPAGE,
      page: () => HomepageView(),
      binding: HomepageBinding(),
    ),
    // GetPage(
    //   name: _Paths.LOGIN,
    //   page: () => LoginView(),
    //   binding: LoginBinding(),
    // ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PETSHOP,
      page: () => AddPetshopView(),
      binding: AddPetshopBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.PETSHOP_DETAIL,
      page: () => PetshopDetailView(),
      binding: PetshopDetailBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ORDER,
      page: () => GroomingOrderView(),
      binding: GroomingOrderBinding(),
    ),
    GetPage(
      name: _Paths.DOCTOR_REGISTRATION,
      page: () => DoctorRegistrationView(),
      binding: DoctorRegistrationBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.PET_HOTEL_ORDER,
      page: () => PetHotelOrderView(),
      binding: PetHotelOrderBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAIL,
      page: () => OrderDetailView(),
      binding: OrderDetailBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_DETAIL,
      page: () => HistoryDetailView(),
      binding: HistoryDetailBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_HOME,
      page: () => AdminHomeView(),
      binding: AdminHomeBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_LIST_USERS,
      page: () => AdminListUsersView(),
      binding: AdminListUsersBinding(),
    ),
    GetPage(
      name: _Paths.SELLER_HOME,
      page: () => SellerHomeView(),
      binding: SellerHomeBinding(),
    ),
    GetPage(
      name: _Paths.SELLER_HISTORY,
      page: () => SellerHistoryView(),
      binding: SellerHistoryBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_FORM,
      page: () => ServiceFormView(),
      binding: ServiceListBinding(),
    ),
    GetPage(
      name: _Paths.SELLER_ORDER_DETAIL,
      page: () => SellerOrderDetailView(),
      binding: SellerOrderDetailBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PETSHOP_APPROVAL,
      page: () => AdminPetshopApprovalView(),
      binding: AdminPetshopApprovalBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME_PAGE,
      page: () => WelcomePageView(),
      binding: WelcomePageBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_PAGE,
      page: () => CategoryPageView(),
      binding: CategoryPageBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_LIST,
      page: () => ServiceListView(),
      binding: ServiceListBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: _Paths.RATING,
      page: () => RatingView(),
      binding: RatingBinding(),
    ),
    GetPage(
      name: _Paths.PET_LIST,
      page: () => PetListView(),
      binding: PetListBinding(),
    ),
    GetPage(
      name: _Paths.PET_FORM,
      page: () => PetFormView(),
      binding: PetFormBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_PET,
      page: () => ChoosePetView(),
      binding: ChoosePetBinding(),
    ),
    GetPage(
      name: _Paths.PACKAGE_FORM,
      page: () => PackageFormView(),
      binding: PackageFormBinding(),
    ),
    GetPage(
      name: _Paths.PETSHOP_LIST,
      page: () => PetshopListView(),
      binding: PetshopListBinding(),
    ),
    GetPage(
      name: _Paths.INFORMATION,
      page: () => InformationView(),
      binding: InformationBinding(),
    ),
    GetPage(
      name: _Paths.PACKAGE_LIST,
      page: () => PackageListView(),
      binding: PackageListBinding(),
    ),
    GetPage(
      name: _Paths.TOPUP,
      page: () => TopUpView(),
      binding: TopUpBinding(),
    ),
  ];
}
