import 'package:get/get.dart';

import '../controllers/telecom_controller.dart';

class TelecomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TelecomController>(
      () => TelecomController(),
    );
  }
}
