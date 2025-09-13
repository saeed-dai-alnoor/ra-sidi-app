import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/status_controller.dart';

class StatusView extends GetView<StatusController> {
  const StatusView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. لون الخلفية البرتقالي
      backgroundColor: Colors.orange,
      body: SafeArea(
        // لتجنب تداخل الواجهة مع شريط الحالة العلوي
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // الجزء العلوي: أيقونة وحالة العملية
              Column(
                children: [
                  const SizedBox(height: 30),
                  // أيقونة التحديث
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.refresh,
                      size: 60,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // نص الحالة
                  const Text(
                    'قيد الانتظار',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // صندوق تفاصيل العملية
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2), // لون شفاف قليلاً
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow('الفاتورة', 'شراء رصيد'),
                        _buildDetailRow(
                          'التاريخ و الزمن',
                          '13-09-2025 08:13:41',
                        ),
                        _buildDetailRow('المبلغ', '1,000.00'),
                        _buildDetailRow('معرف الفاتورة', '968463592'),
                        _buildDetailRow('رقم العملية', '20194698177'),
                      ],
                    ),
                  ),
                ],
              ),

              // الجزء السفلي: الأزرار
              Column(
                children: [
                  // زر موافق
                  ElevatedButton(
                    onPressed: () {
                      // العودة إلى الصفحة الرئيسية
                      Get.offAllNamed('/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('موافق', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 20),
                  // أزرار الإجراءات الأخرى
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(Icons.download, 'تحميل'),
                      _buildActionButton(Icons.print, 'طباعة'),
                      _buildActionButton(Icons.share, 'مشاركة'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // الحقوق
                  const Text(
                    '© 2024 بنك الخرطوم | بنكك حساب',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ويدجت مساعد لعرض تفاصيل العملية
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت مساعد لأزرار الإجراءات السفلية
  Widget _buildActionButton(IconData icon, String label) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
