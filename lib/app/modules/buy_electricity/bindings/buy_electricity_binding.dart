import 'package:get/get.dart';

import '../controllers/buy_electricity_controller.dart';

class BuyElectricityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyElectricityController>(
      () => BuyElectricityController(),
    );
  }
}
