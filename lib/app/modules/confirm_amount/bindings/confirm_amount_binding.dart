import 'package:get/get.dart';

import '../controllers/confirm_amount_controller.dart';

class ConfirmAmountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmAmountController>(
      () => ConfirmAmountController(),
    );
  }
}
