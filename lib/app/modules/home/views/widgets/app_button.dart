import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text; // النص المعروض على الزر
  final VoidCallback? onPressed; // الأكشن عند الضغط
  final List<Color> gradientColors; // ألوان التدرج (اختياري)
  final double width;
  final double height;
  final bool enabled; // متغير للتحكم في التفعيل
  final Widget? child; // ويدجت اختياري

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.gradientColors = const [Color(0xFFFF6B35), Color(0xFFFFA726)],
    this.width = 240,
    this.height = 44,
    this.enabled = true, // القيمة الافتراضية مفعّل
    this.child, // ويدجت اختياري
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 160),
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: enabled
                  ? LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : const LinearGradient(
                      colors: [
                        Color.fromRGBO(226, 218, 218, 0.857),
                        Color.fromRGBO(226, 218, 218, 0.857),
                      ],
                    ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              height: height,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:
                  child ??
                  Text(
                    text,
                    style: TextStyle(
                      color: enabled
                          ? Colors.white.withValues(alpha: 1)
                          : Colors.black26,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
