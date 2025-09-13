import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/telecom_controller.dart';

class TelecomView extends GetView<TelecomController> {
  const TelecomView({super.key});
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
        title: const Text('اتصالات / إنترنت'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            // سنقوم بإنشاء ويدجت مخصص لهذه الأزرار
            _buildProviderButton(
              'أم تي إن',
              'assets/mtn_logo.png', // سنضيف هذه الصورة لاحقاً
              Colors.orange, // لون خلفية الشعار
            ),
            const SizedBox(height: 12),
            _buildProviderButton(
              'زين',
              'assets/zain_logo.png', // سنضيف هذه الصورة لاحقاً
              Colors.purple, // لون خلفية الشعار
            ),
            const SizedBox(height: 12),
            _buildProviderButton(
              'سوداني',
              'assets/sudani_logo.png', // سنضيف هذه الصورة لاحقاً
              Colors.blue, // لون خلفية الشعار
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت مخصص لإنشاء زر شركة الاتصالات
  Widget _buildProviderButton(
    String providerName,
    String logoPath,
    Color logoBgColor,
  ) {
    return Card(
      color: Colors.grey[50],
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3), // الزوايا
        side: BorderSide(
          color: Colors.black12, // لون البوردر
          width: 2, // سماكة البوردر
        ),
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.BUY_CREDIT, arguments: providerName);
          // print('$providerName clicked');
          // هنا سننتقل إلى الصفحة التالية (صفحة شراء الرصيد مثلاً)
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // شعار الشركة
              CircleAvatar(
                radius: 25,
                backgroundColor: logoBgColor,
                // سنستخدم أيقونة مؤقتة الآن
                child: const Icon(
                  Icons.signal_cellular_alt,
                  color: Colors.white,
                ),
                // child: Image.asset(logoPath, height: 30), // سنستخدم هذا السطر بعد إضافة الصور
              ),
              // اسم الشركة
              Text(
                providerName,
                style: const TextStyle(
                  // color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // أيقونة السهم
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
