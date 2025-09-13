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
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.fill,
          height: 40,
        ), // سنضيف هذا الشعار لاحقاً
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // لاستيعاب المحتوى إذا كان أطول من الشاشة
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. عنوان العملية
            const Text(
              'شراء رصيد',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 2. صندوق تفاصيل العملية
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  _buildInfoRow('رقم الموبايل:', '968463592'),
                  const Divider(),
                  _buildInfoRow('أدنى مبلغ:', '1'),
                  const Divider(),
                  _buildInfoRow('أعلى مبلغ:', '50000'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 3. صندوق اختيار الحساب
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: '1003077111340001', // قيمة افتراضية
                  icon: const Icon(Icons.arrow_drop_down),
                  items: <String>['1003077111340001', 'حساب آخر']
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                      .toList(),
                  onChanged: (String? newValue) {
                    // منطق تغيير الحساب
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 4. حقل إدخال المبلغ
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'أدخل المبلغ',
                prefixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
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

            // 5. أزرار الإلغاء والتأكيد
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton('تأكيد', color: const Color(0xFFFFA726), () {
                  // print('تأكيد clicked');
                  Get.offNamed(Routes.STATUS);
                  // هنا سننتقل لصفحة قيد الانتظار
                }),
                _buildActionButton('إلغاء', () => Get.back()),
              ],
            ),
          ],
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
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // ويدجت مساعد لإنشاء الأزرار الحمراء
  Widget _buildActionButton(
    String label,
    VoidCallback onPressed, {
    Color? color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // إذا لم يتم توفير لون، استخدم الأحمر، وإلا استخدم اللون المُمرر
        backgroundColor: color ?? Colors.red[700],
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
