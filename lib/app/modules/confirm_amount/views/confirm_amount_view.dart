import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/confirm_amount_controller.dart';

class ConfirmAmountView extends GetView<ConfirmAmountController> {
  const ConfirmAmountView({super.key});
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
        title: Text('شعار باسكودا', style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... عنوان العملية ...
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  // -->> تعديل: عرض رقم الهاتف من الـ Controller <<--
                  _buildInfoRow('رقم الموبايل:', controller.phoneNumber),
                  const Divider(),
                  // -->> تعديل: عرض المبالغ من الـ Controller <<--
                  _buildInfoRow('أدنى مبلغ:', controller.minAmount.toString()),
                  const Divider(),
                  _buildInfoRow('أعلى مبلغ:', controller.maxAmount.toString()),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // ... صندوق اختيار الحساب ...
            const SizedBox(height: 20),

            // -->> تعديل: حقل إدخال المبلغ <<--
            Obx(() {
              return TextField(
                controller: controller.amountController, // ربط الـ Controller
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'أدخل المبلغ',
                  errorText: controller.errorText.value, // عرض رسالة الخطأ
                  prefixIcon: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'SDG',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              );
            }),
            const SizedBox(height: 30),

            // -->> تعديل: أزرار الإلغاء والتأكيد <<--
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() {
                  return _buildActionButton(
                    'تأكيد',
                    // تفعيل/تعطيل الزر بناءً على الحالة
                    controller.isButtonEnabled.value
                        ? () => Get.offNamed(Routes.STATUS)
                        : null,
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

  // ... ويدجت _buildInfoRow ...
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 17)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }

  // تعديل بسيط على الويدجت ليقبل دالة onPressed تكون nullable
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
