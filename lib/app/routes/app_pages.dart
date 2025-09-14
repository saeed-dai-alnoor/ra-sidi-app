import 'package:get/get.dart';

import '../modules/bills/bindings/bills_binding.dart';
import '../modules/bills/views/bills_view.dart';
import '../modules/buy_credit/bindings/buy_credit_binding.dart';
import '../modules/buy_credit/views/buy_credit_view.dart';
import '../modules/buy_electricity/bindings/buy_electricity_binding.dart';
import '../modules/buy_electricity/views/buy_electricity_view.dart';
import '../modules/confirm_amount/bindings/confirm_amount_binding.dart';
import '../modules/confirm_amount/views/confirm_amount_view.dart';
import '../modules/confirm_electricity/bindings/confirm_electricity_binding.dart';
import '../modules/confirm_electricity/views/confirm_electricity_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/status/bindings/status_binding.dart';
import '../modules/status/views/status_view.dart';
import '../modules/telecom/bindings/telecom_binding.dart';
import '../modules/telecom/views/telecom_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.BILLS,
      page: () => const BillsView(),
      binding: BillsBinding(),
    ),
    GetPage(
      name: _Paths.TELECOM,
      page: () => const TelecomView(),
      binding: TelecomBinding(),
    ),
    GetPage(
      name: _Paths.BUY_CREDIT,
      page: () => const BuyCreditView(),
      binding: BuyCreditBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRM_AMOUNT,
      page: () => const ConfirmAmountView(),
      binding: ConfirmAmountBinding(),
    ),
    GetPage(
      name: _Paths.STATUS,
      page: () => const StatusView(),
      binding: StatusBinding(),
    ),
    GetPage(
      name: _Paths.BUY_ELECTRICITY,
      page: () => const BuyElectricityView(),
      binding: BuyElectricityBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRM_ELECTRICITY,
      page: () => const ConfirmElectricityView(),
      binding: ConfirmElectricityBinding(),
    ),
  ];
}
