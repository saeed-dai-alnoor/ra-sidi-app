import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmElectricityController extends GetxController {
  // 1. متغيرات لتخزين البيانات القادمة
  late String meterNumber;
  late String meterType;

  // 2. متغير لإدارة حقل المبلغ
  final amountController = TextEditingController();

  // 3. تحديد أدنى وأعلى مبلغ
  final int minAmount = 10000;
  final int maxAmount = 3000000;

  @override
  void onInit() {
    super.onInit();
    // استقبال البيانات التي مررناها كـ Map
    final Map<String, dynamic> args = Get.arguments;
    meterNumber = args['meterNumber'];
    meterType = args['meterType'];

    // -->> التعديل الرئيسي هنا <<--
    // سنجعل الـ listener يطلب من الواجهة أن تحدث نفسها فقط
    amountController.addListener(() {
      update(); // هذا السطر يخبر كل ويدجت GetBuilder أو Obx أن تعيد بناء نفسها
    });
  }

  // -->> دالة جديدة للتحقق من الصحة <<--
  // هذه الدالة ستقوم بإرجاع رسالة الخطأ كنص، أو null إذا كان الإدخال صحيحاً
  // سيتم استدعاؤها مباشرة من الواجهة (View)
  String? validateAmount() {
    final String text = amountController.text;

    if (text.isEmpty) {
      return null; // لا تظهر خطأ إذا كان الحقل فارغاً
    }
    final int? amount = int.tryParse(text);
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

  @override
  void onClose() {
    amountController.dispose(); // سيتم حذف الـ listener تلقائياً
    super.onClose();
  }
}