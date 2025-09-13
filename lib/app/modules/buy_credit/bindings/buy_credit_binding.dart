import 'package:get/get.dart';

import '../controllers/buy_credit_controller.dart';

class BuyCreditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyCreditController>(
      () => BuyCreditController(),
    );
  }
}
