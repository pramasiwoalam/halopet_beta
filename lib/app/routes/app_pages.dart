import 'package:get/get.dart';
import 'package:halopet_beta/app/modules/additional_info/bindings/additional_info_binding.dart';
import 'package:halopet_beta/app/modules/additional_info/views/additional_info_view.dart';
import 'package:halopet_beta/app/modules/additional_info/views/delivery_info.dart';
import 'package:halopet_beta/app/modules/admin_list_users/views/admin_users_detail_view.dart';
import 'package:halopet_beta/app/modules/bank_account_reg/bindings/bank_account_reg_binding.dart';
import 'package:halopet_beta/app/modules/bank_account_reg/views/bank_account_reg_view.dart';
import 'package:halopet_beta/app/modules/choose_room/bindings/choose_room_binding.dart';
import 'package:halopet_beta/app/modules/choose_room/views/choose_room_view.dart';
import 'package:halopet_beta/app/modules/delivery_list/bindings/delivery_list_binding.dart';
import 'package:halopet_beta/app/modules/delivery_list/views/delivery_list_view.dart';
import 'package:halopet_beta/app/modules/edit_package/bindings/edit_package_binding.dart';
import 'package:halopet_beta/app/modules/edit_package/views/edit_package_view.dart';
import 'package:halopet_beta/app/modules/edit_petshop_form/bindings/edit_petshop_form_binding.dart';
import 'package:halopet_beta/app/modules/edit_profile/bindings/edit_profile_binding.dart';
import 'package:halopet_beta/app/modules/edit_profile/views/edit_profile_view.dart';
import 'package:halopet_beta/app/modules/edit_service/bindings/edit_service_binding.dart';
import 'package:halopet_beta/app/modules/edit_service/views/edit_service_view.dart';
import 'package:halopet_beta/app/modules/explore_service/views/explore_service_view.dart';
import 'package:halopet_beta/app/modules/medical_list_form/views/medical_list_form_view.dart';
import 'package:halopet_beta/app/modules/medical_list_reg/bindings/medical_list_reg_binding.dart';
import 'package:halopet_beta/app/modules/medical_list_reg/views/medical_list_reg_view.dart';
import 'package:halopet_beta/app/modules/notification_list/bindings/notification_list_binding.dart';
import 'package:halopet_beta/app/modules/package_list/bindings/package_list_binding.dart';
import 'package:halopet_beta/app/modules/package_list/views/package_list_view.dart';
import 'package:halopet_beta/app/modules/rating/bindings/rating_binding.dart';
import 'package:halopet_beta/app/modules/rating/views/rating_view.dart';
import 'package:halopet_beta/app/modules/service_form/views/service_form_view.dart';
import 'package:halopet_beta/app/modules/service_list/bindings/service_list_binding.dart';
import 'package:halopet_beta/app/modules/service_list/views/service_list_view.dart';
import 'package:halopet_beta/app/modules/topup/bindings/topup_binding.dart';
import 'package:halopet_beta/app/modules/topup/views/topup_view.dart';
import 'package:halopet_beta/app/modules/withdraw/bindings/withdraw_binding.dart';
import 'package:halopet_beta/app/modules/withdraw/views/withdraw_view.dart';
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
import '../modules/choose_date/bindings/choose_date_binding.dart';
import '../modules/choose_date/views/choose_date_view.dart';
import '../modules/choose_pet/bindings/choose_pet_binding.dart';
import '../modules/choose_pet/views/choose_pet_view.dart';
import '../modules/choose_session/bindings/choose_session_binding.dart';
import '../modules/choose_session/views/choose_session_view.dart';

import '../modules/edit_petshop/bindings/edit_petshop_binding.dart';
import '../modules/edit_petshop/views/edit_petshop_view.dart';
import '../modules/edit_petshop_form/views/edit_petshop_form_view.dart';
import '../modules/explore_service/bindings/explore_service_binding.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/grooming_order/bindings/grooming_order_binding.dart';
import '../modules/grooming_order/views/create_order_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/history_detail/bindings/history_detail_binding.dart';
import '../modules/history_detail/views/history_detail_view.dart';
import '../modules/homepage/bindings/homepage_binding.dart';
import '../modules/homepage/views/homepage_view.dart';
import '../modules/information/bindings/information_binding.dart';
import '../modules/information/views/information_view.dart';
import '../modules/medical_list/bindings/medical_list_binding.dart';
import '../modules/medical_list/views/medical_list_view.dart';
import '../modules/medical_records_form/bindings/medical_records_form_binding.dart';
import '../modules/medical_records_form/views/medical_records_form_view.dart';
import '../modules/medical_records_list/bindings/medical_records_list_binding.dart';
import '../modules/medical_records_list/views/medical_records_list_view.dart';
import '../modules/notification_detail/bindings/notification_detail_binding.dart';
import '../modules/notification_detail/views/notification_detail_view.dart';
import '../modules/notification_list/views/notification_list_view.dart';
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
import '../modules/session_detail/bindings/session_detail_binding.dart';
import '../modules/session_detail/views/session_detail_view.dart';
import '../modules/session_list/bindings/session_list_binding.dart';
import '../modules/session_list/views/session_list_view.dart';
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
      page: () => CreateOrderView(),
      binding: GroomingOrderBinding(),
    ),
    GetPage(
      name: _Paths.ADDITIONAL_INFO,
      page: () => AdditionalInfoView(),
      binding: AdditionalInfoBinding(),
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
    GetPage(
      name: _Paths.DELIVERY,
      page: () => DeliveryListView(),
      binding: DeliveryListBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_LIST,
      page: () => NotificationListView(),
      binding: NotificationListBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_DETAIL,
      page: () => NotificationDetailView(),
      binding: NotificationDetailBinding(),
    ),
    GetPage(
      name: _Paths.SESSION_LIST,
      page: () => SessionListView(),
      binding: SessionListBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_SESSION,
      page: () => ChooseSessionView(),
      binding: ChooseSessionBinding(),
    ),
    GetPage(
      name: _Paths.SESSION_DETAIL,
      page: () => SessionDetailView(),
      binding: SessionDetailBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_DATE,
      page: () => ChooseDateView(),
      binding: ChooseDateBinding(),
    ),
    GetPage(
      name: _Paths.MEDICAL_LIST,
      page: () => MedicalListView(),
      binding: MedicalListBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_ROOM,
      page: () => ChooseRoomView(),
      binding: ChooseRoomBinding(),
    ),
    GetPage(
      name: _Paths.MEDICAL_RECORDS_LIST,
      page: () => MedicalRecordsListView(),
      binding: MedicalRecordsListBinding(),
    ),
    GetPage(
      name: _Paths.MEDICAL_RECORDS_FORM,
      page: () => MedicalRecordsFormView(),
      binding: MedicalRecordsFormBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PETSHOP,
      page: () => EditPetshopView(),
      binding: EditPetshopBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PETSHOP_FORM,
      page: () => EditPetshopFormView(),
      binding: EditPetshopFormBinding(),
    ),
    GetPage(
      name: _Paths.EXPLORE_SERVICE,
      page: () => ExploreServiceView(),
      binding: ExploreServiceBinding(),
    ),
    GetPage(
      name: _Paths.MEDICAL_LIST_FORM,
      page: () => MedicalListFormView(),
      binding: MedicalRecordsFormBinding(),
    ),
    GetPage(
      name: _Paths.MEDICAL_LIST_REG,
      page: () => MedicalListRegView(),
      binding: MedicalListRegBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW,
      page: () => WithdrawView(),
      binding: WithdrawBinding(),
    ),
    GetPage(
      name: _Paths.BANK_ACCOUNT_REG,
      page: () => BankAccountRegView(),
      binding: BankAccountRegBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_USER_DETAIL,
      page: () => AdminUserDetailView(),
      binding: AdminListUsersBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_SERVICE,
      page: () => EditServiceView(),
      binding: EditServiceBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PACKAGE,
      page: () => EditPackageView(),
      binding: EditPackageBinding(),
    ),
  ];
}
