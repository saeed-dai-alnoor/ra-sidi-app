import 'package:get/get.dart';

import '../controllers/confirm_electricity_controller.dart';

class ConfirmElectricityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmElectricityController>(
      () => ConfirmElectricityController(),
    );
  }
}
