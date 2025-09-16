import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final storage = GetStorage();
  // late final token = storage.read('token');
  late final name = storage.read('name');
  void _checkAuth() async {
    await Future.delayed(Duration(milliseconds: 700)); // وقت الانتظار
    if (name != null) {
      Get.offAllNamed(Routes.HOME, arguments: {"name": name}); // المستخدم مسجل
    } else {
      Get.offAllNamed(Routes.LOGIN); // غير مسجل
    }
  }

  @override
  void onReady() {
    super.onReady();
    // تأكد من ظهورها
    _checkAuth();
  }

  @override
  void onInit() {
    super.onInit();
    // GetStorage().erase();
  }
}
