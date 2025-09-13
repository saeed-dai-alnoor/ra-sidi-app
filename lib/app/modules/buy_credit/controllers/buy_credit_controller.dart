import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyCreditController extends GetxController {
  // 1. متغير لتخزين اسم الشركة القادم من الصفحة السابقة
  late String providerName;

  // 2. Controller لحقل النص للتحكم فيه برمجياً
  final phoneController = TextEditingController();

  // 3. متغيرات تفاعلية (reactive) لتتبع الحالة
  final RxnString errorText = RxnString(null); // لتخزين رسالة الخطأ
  final RxBool isButtonEnabled = RxBool(false); // لتفعيل/تعطيل الزر

  // هذه الدالة تعمل عند تهيئة الـ Controller
  @override
  void onInit() {
    super.onInit();
    // استقبال اسم الشركة الذي مررناه
    providerName = Get.arguments as String;

    // الاستماع للتغيرات في حقل النص لتنفيذ التحقق مع كل تغيير
    phoneController.addListener(_validatePhoneNumber);
  }

  // دالة التحقق من الصحة
  void _validatePhoneNumber() {
    String phoneNumber = phoneController.text;

    // الشرط الأول: يجب أن يكون 9 أرقام
    if (phoneNumber.length != 9) {
      errorText.value = 'يجب أن يتكون الرقم من 9 أرقام.';
      isButtonEnabled.value = false;
      return; // توقف هنا
    }

    // الشرط الثاني: التحقق من الرقم الأول بناءً على اسم الشركة
    if ((providerName == 'زين' || providerName == 'أم تي إن') &&
        !phoneNumber.startsWith('9')) {
      errorText.value = 'يجب أن يبدأ الرقم بـ 9 لـ (زين أو MTN).';
      isButtonEnabled.value = false;
      return; // توقف هنا
    }

    if (providerName == 'سوداني' && !phoneNumber.startsWith('1')) {
      errorText.value = 'يجب أن يبدأ الرقم بـ 1 لـ (سوداني).';
      isButtonEnabled.value = false;
      return; // توقف هنا
    }

    // إذا نجح في كل الشروط
    errorText.value = null; // لا يوجد خطأ
    isButtonEnabled.value = true; // تفعيل الزر
  }

  // للتأكد من حذف الـ listener عند إغلاق الصفحة لتجنب تسريب الذاكرة
  @override
  void onClose() {
    phoneController.removeListener(_validatePhoneNumber);
    phoneController.dispose();
    super.onClose();
  }
}
