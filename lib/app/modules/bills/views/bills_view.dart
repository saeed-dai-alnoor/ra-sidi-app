import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ra_sidi_app/app/routes/app_pages.dart';

import '../controllers/bills_controller.dart';

class BillsView extends GetView<BillsController> {
  const BillsView({super.key});
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
        title: const Text('دفع فواتير'),
        centerTitle: true,
        // زر الرجوع سيضاف تلقائياً بواسطة GetX عند التنقل
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // سنستخدم GridView كما في الصفحة الرئيسية
        child: GridView.count(
          crossAxisCount: 2, // عمودين فقط هذه المرة
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildServiceButton(Icons.power, 'شراء الكهرباء'),
            _buildServiceButton(Icons.wifi, 'اتصالات/إنترنت'),
            _buildServiceButton(Icons.flight, 'خطوط الطيران'),
            _buildServiceButton(Icons.home, 'خدمات حكومية'),
            _buildServiceButton(Icons.shopping_basket, 'التسوق عبر الانترنت'),
            _buildServiceButton(Icons.directions_car, 'وسائل النقل'),
            _buildServiceButton(Icons.local_gas_station, 'الوقود'),
            _buildServiceButton(Icons.favorite, 'التبرعات'),
          ],
        ),
      ),
    );
  }

  // ويدجت مخصص لإنشاء الأزرار في هذه الصفحة
  Widget _buildServiceButton(IconData icon, String label) {
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
          if (label == 'اتصالات/إنترنت') {
            Get.toNamed(Routes.TELECOM); // الانتقال لصفحة الاتصالات
          }else if (label == 'شراء الكهرباء') { // <-- هذا هو التعديل
          Get.toNamed(Routes.BUY_ELECTRICITY);
        } else {
          // print('$label clicked');
        }
      },
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 45, color: Color(0xFFFFA726)),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3, // سطر واحد فقط
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
