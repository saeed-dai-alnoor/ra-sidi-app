import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmAmountController extends GetxController {
  // 1. متغيرات لتخزين البيانات القادمة والحالة
  late String phoneNumber;
  final amountController = TextEditingController();

  // 2. متغيرات تفاعلية (reactive)
  final RxnString errorText = RxnString(null); // لرسالة خطأ حقل المبلغ
  final RxBool isButtonEnabled = RxBool(false); // لتفعيل/تعطيل زر التأكيد

  // 3. تحديد أدنى وأعلى مبلغ
  final int minAmount = 1000;
  final int maxAmount = 50000;

  @override
  void onInit() {
    super.onInit();
    // استقبال رقم الهاتف الذي مررناه
    phoneNumber = Get.arguments as String;

    // الاستماع للتغيرات في حقل المبلغ لتنفيذ التحقق
    amountController.addListener(_validateAmount);
  }

  String? validateAmount(String? value) {
  if (value == null || value.isEmpty) {
    return null; // لا تظهر خطأ إذا كان الحقل فارغاً
  }
  final int? amount = int.tryParse(value);
  if (amount == null) {
    return 'الرجاء إدخال رقم صحيح.';
  } else if (amount < minAmount) {
    return 'أدنى مبلغ هو $minAmount';
  } else if (amount > maxAmount) {
    return 'أعلى مبلغ هو $maxAmount';
  }
  // إذا كان كل شيء صحيحاً
  return null;
}

  // دالة التحقق من المبلغ
  void _validateAmount() {
    // تجاهل التحقق إذا كان الحقل فارغاً
    if (amountController.text.isEmpty) {
      errorText.value = null;
      isButtonEnabled.value = false;
      return;
    }

    // تحويل النص إلى رقم للتحقق
    final int? amount = int.tryParse(amountController.text);

    if (amount == null) {
      errorText.value = 'الرجاء إدخال رقم صحيح.';
      isButtonEnabled.value = false;
    } else if (amount < minAmount) {
      errorText.value = 'أدنى مبلغ هو $minAmount';
      isButtonEnabled.value = false;
    } else if (amount > maxAmount) {
      errorText.value = 'أعلى مبلغ هو $maxAmount';
      isButtonEnabled.value = false;
    } else {
      // إذا نجح في كل الشروط
      errorText.value = null; // لا يوجد خطأ
      isButtonEnabled.value = true; // تفعيل الزر
    }
  }

  @override
  void onClose() {
    amountController.removeListener(_validateAmount);
    amountController.dispose();
    super.onClose();
  }
}
