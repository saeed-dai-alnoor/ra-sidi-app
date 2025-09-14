import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/buy_credit_controller.dart';

class BuyCreditView extends GetView<BuyCreditController> {
  const BuyCreditView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFFA726),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Get.back(),
        ),
        title: Text('شراء رصيد - ${controller.providerName}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // -->> هذا هو التعديل الرئيسي <<--
            // Obx تجعل الويدجت "يراقب" التغيرات في متغيرات الـ Controller
            Obx(() {
              return TextField(
                // 1. ربط الـ Controller بحقل النص
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                // 2. تحديد الطول الأقصى للإدخال
                maxLength: 9,
                decoration: InputDecoration(
                  labelText: 'أدخل رقم الموبايل',
                  hintText: controller.providerName == 'سوداني'
                      ? '1XXXXXXXX'
                      : '9XXXXXXXX',
                  // 3. عرض رسالة الخطأ القادمة من الـ Controller
                  errorText: controller.errorText.value,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              );
            }),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() {
                  return _buildActionButton(
                    'إرسال',
                    // 4. تفعيل/تعطيل الزر بناءً على متغير isButtonEnabled
                    controller.isButtonEnabled.value
                        ? () => Get.toNamed(
                            Routes.CONFIRM_AMOUNT,
                            arguments: controller.phoneController.text,
                          )
                        : null, // تمرير null يعطل الزر تلقائياً
                    color: const Color(0xFFFFA726),
                  );
                }),
                _buildActionButton('إلغاء', () => Get.back()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت مخصص لإنشاء الأزرار الحمراء
  // سنضيف متغيراً اختيارياً 'Color? color'
  // أضفنا '?' هنا لجعل onPressed يقبل قيمة null
  Widget _buildActionButton(
    String label,
    VoidCallback? onPressed, {
    Color? color,
  }) {
    return ElevatedButton(
      onPressed:
          onPressed, // الآن onPressed يمكن أن يكون null، وهذا ما يريده ElevatedButton لتعطيل الزر
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.red[700],
        disabledBackgroundColor: Colors.grey,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }


}
