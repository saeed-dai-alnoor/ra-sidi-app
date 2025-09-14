import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/confirm_electricity_controller.dart';

class ConfirmElectricityView extends GetView<ConfirmElectricityController> {
  const ConfirmElectricityView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('شعار باسكودا'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFFA726),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        // -->> التعديل الرئيسي: استخدام GetBuilder <<--
        // GetBuilder يعيد بناء ما بداخله كلما تم استدعاء controller.update()
        child: GetBuilder<ConfirmElectricityController>(
          builder: (controller) {
            // 1. نقوم بحساب حالة الخطأ والزر هنا في كل مرة يتم إعادة البناء
            final String? error = controller.validateAmount();
            final bool isButtonEnabled =
                error == null && controller.amountController.text.isNotEmpty;

            return Column(
              children: [
                // صندوق تفاصيل العملية (لم يتغير)
                Column(
                  children: [
                    _buildInfoRow('رقم العداد:', controller.meterNumber),
                    _buildInfoRow(
                      'رقم التعرفة:',
                      controller.meterType.substring(1, 3),
                    ),
                    _buildInfoRow(
                      'أدنى مبلغ:',
                      controller.minAmount.toString(),
                    ),
                    _buildInfoRow(
                      'أعلى مبلغ:',
                      controller.maxAmount.toString(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 2. حقل إدخال المبلغ
                TextField(
                  controller: controller.amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'أدخل المبلغ',
                    errorText: error, // 3. استخدام متغير الخطأ الذي حسبناه
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
                ),
                const SizedBox(height: 30),
                const SizedBox(height: 30),

                // 4. أزرار الإلغاء والتأكيد
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      'تأكيد',
                      // 5. استخدام متغير حالة الزر الذي حسبناه
                      isButtonEnabled
                          ? () => Get.offNamed(Routes.STATUS)
                          : null,
                      color: const Color(0xFFFFA726),
                    ),
                    _buildActionButton('إلغاء', () => Get.back()),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ويدجت مساعد لعرض صف معلومات
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
