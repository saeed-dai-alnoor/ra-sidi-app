import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void logout() async {
    await GetStorage().erase(); // مسح كل البيانات المخزنة
    Get.offAllNamed(Routes.LOGIN); // العودة لصفحة تسجيل الدخول
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
