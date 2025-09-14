import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyElectricityController extends GetxController {
  // قائمة بأنواع العدادات
  final List<String> meterTypes = [
    '(01) عداد سكني 3 خط',
    '(02) عداد سكني 1 خط',
    '(03) عداد تجاري',
  ];

  // متغير تفاعلي لتخزين النوع المختار حالياً
  // Rxn<String> يعني أنه يمكن أن يكون String أو null
  final Rxn<String> selectedMeterType = Rxn<String>();

  // دالة لتحديث القيمة المختارة
  void selectMeterType(String value) {
    selectedMeterType.value = value;
  }
    // --- الإضافات الجديدة ---
  final meterNumberController = TextEditingController();
  final RxnString meterNumberError = RxnString(null); // لرسالة خطأ رقم العداد
  final RxBool isFormValid = RxBool(false); // لتفعيل/تعطيل زر الإرسال

  @override
  void onInit() {
    super.onInit();
    // الاستماع للتغيرات في حقل النص ونوع العداد
    meterNumberController.addListener(validateForm);
    selectedMeterType.listen((_) => validateForm());
  }

  void validateForm() {
    // التحقق من رقم العداد
    if (meterNumberController.text.length != 11) {
      meterNumberError.value = 'رقم العداد يجب أن يتكون من 11 رقمًا.';
      isFormValid.value = false;
      return; // توقف هنا
    } else {
      meterNumberError.value = null; // لا يوجد خطأ
    }

    // التحقق من اختيار نوع العداد
    if (selectedMeterType.value == null) {
      isFormValid.value = false;
      return; // توقف هنا
    }

    // إذا كانت كل الشروط صحيحة
    isFormValid.value = true;
  }

  // دالة لتحديث القيمة المختارة
  

  @override
  void onClose() {
    meterNumberController.dispose();
    super.onClose();
  }
}

