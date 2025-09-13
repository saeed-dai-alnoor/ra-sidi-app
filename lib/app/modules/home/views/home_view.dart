import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ra_sidi_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final userName = args?['name'] ?? "ضيف";
    return Scaffold(
      backgroundColor: Colors.white,
      // 1. الشريط العلوي (AppBar)
      appBar: AppBar(
        backgroundColor: Color(0xFFFFA726),

        title: const Text(
          'باسكودا',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, size: 30),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.login, size: 30),
            onPressed: () => controller.logout(),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 30),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2. رسالة الترحيب
            Text(
              "مرحبا، $userName 👋",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 3. شبكة الأيقونات
            Expanded(
              child: GridView.count(
                crossAxisCount: 3, // 3 أعمدة
                crossAxisSpacing: 4, // مسافة أفقية بين العناصر
                mainAxisSpacing: 4, // مسافة رأسية بين العناصر
                children: <Widget>[
                  // سنقوم بإنشاء ويدجت مخصص لهذه الأيقونات لاحقاً
                  // الآن سنستخدم مثالاً بسيطاً
                  _buildGridItem(Icons.account_balance_wallet, 'تفاصيل الحساب'),
                  _buildGridItem(Icons.receipt_long, 'دفع فواتير'),
                  _buildGridItem(Icons.swap_horiz, 'تحويلات'),
                  _buildGridItem(Icons.arrow_downward, 'سحب بدون بطاقة'),
                  _buildGridItem(Icons.qr_code_scanner, 'بنكك PAY'),
                  _buildGridItem(Icons.request_page, 'طلب الودائع الاستثمارية'),
                  _buildGridItem(Icons.person_add, 'إدارة المستفيدين'),
                  _buildGridItem(Icons.history, 'المعاملات السابقة'),
                  _buildGridItem(Icons.credit_card, 'إدارة البطاقات'),
                  _buildGridItem(Icons.event_note, 'طلبات'),
                  _buildGridItem(Icons.schedule_send, 'أمر دفع دائم'),
                  _buildGridItem(Icons.settings, 'الضبط'),
                  _buildGridItem(Icons.shopping_cart, 'التجارة الإلكترونية'),
                  _buildGridItem(Icons.language, 'خدمات العملات الأجنبية'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت بسيط لإنشاء كل عنصر في الشبكة
  Widget _buildGridItem(IconData icon, String label) {
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
          if (label == 'دفع فواتير') {
            Get.toNamed(Routes.BILLS); // استخدم المسار الذي عرفناه
          } else {
            // print('$label clicked');
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 40.0, color: Color(0xFFFFA726)),
            const SizedBox(height: 8.0),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
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
