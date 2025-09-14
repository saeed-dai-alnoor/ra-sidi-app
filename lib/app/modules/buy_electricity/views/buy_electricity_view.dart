// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/buy_electricity_controller.dart';

class BuyElectricityView extends GetView<BuyElectricityController> {
  const BuyElectricityView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('شراء الكهرباء'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFFA726),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 1. حقل إدخال رقم العداد
            Obx(() {
              return TextField(
                controller:
                    controller.meterNumberController, // 1. ربط الـ Controller
                keyboardType: TextInputType.number,
                maxLength: 11, // 2. تحديد الطول الأقصى
                decoration: InputDecoration(
                  labelText: 'أدخل رقم العداد',
                  border: const OutlineInputBorder(),
                  errorText:
                      controller.meterNumberError.value, // 3. عرض رسالة الخطأ
                ),
              );
            }),
            const SizedBox(height: 20),

            // 2. حقل اختيار نوع العداد (الذي سيفتح النافذة المنبثقة)
            // نستخدم Obx لمراقبة التغييرات على نوع العداد المختار
            Obx(() {
              return InkWell(
                onTap: () {
                  // عند الضغط، نعرض النافذة المنبثقة
                  _showMeterTypeDialog(context);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'اختر نوع العداد (رقم التعرفة)',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // عرض النص المختار أو نص افتراضي
                      Text(
                        controller.selectedMeterType.value ?? 'لم يتم الاختيار',
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 30),

            // 3. أزرار الإلغاء والإرسال
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() {
                  return _buildActionButton(
                    'إرسال',
                    color: Color(0xFFFFA726),
                    // 4. تفعيل/تعطيل الزر بناءً على صحة النموذج
                    controller.isFormValid.value
                        ? () {
                            // -->> هنا سنمرر البيانات في المرحلة التالية <<--
                            Get.toNamed(
                              Routes.CONFIRM_ELECTRICITY,
                              arguments: {
                                'meterNumber':
                                    controller.meterNumberController.text,
                                'meterType': controller.selectedMeterType.value,
                              },
                            );
                          }
                        : null, // تعطيل الزر
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

  // ويدجت مساعد لإنشاء الأزرار
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
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  // دالة لعرض النافذة المنبثقة (Dialog)
  void _showMeterTypeDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('اختر نوع العداد (رقم التعرفة)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: controller.meterTypes.map((type) {
            return Obx(() {
              return RadioListTile<String>(
                title: Text(type),
                value: type,
                groupValue: controller.selectedMeterType.value,
                onChanged: (value) {
                  controller.selectMeterType(value!);
                },
              );
            });
          }).toList(),
        ),
        actions: [
          Row(
            children: [
              _buildActionButton(
                'موافق',
                () => Get.back(),
                color: const Color(0xFFFFA726),
              ),
              SizedBox(width: 5),
              _buildActionButton('إلغاء', () => Get.back()),
            ],
          ),
        ],
      ),
    );
  }
}
