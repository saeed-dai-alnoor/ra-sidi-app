import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../home/views/widgets/app_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final FocusNode emailFocus = FocusNode();
    final FocusNode passwordFocus = FocusNode();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('مرحباً,', style: TextStyle(fontSize: 30)),
                          SizedBox(height: 5),
                          Text(
                            'سجّل الدخول للمتابعة',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.SIGN_UP),
                        child: const Text(
                          'إنشاء حساب',
                          style: TextStyle(color: Colors.orange, fontSize: 16),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.emailController,
                    focusNode: emailFocus,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'البريد الإلكتروني',
                    ),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال البريد الإلكتروني';
                      } else if (!GetUtils.isEmail(value)) {
                        return 'الرجاء إدخال بريد إلكتروني صحيح';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.passwordController,
                    focusNode: passwordFocus,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    obscureText: !controller.isPasswordVisible.value,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور',
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال كلمة المرور';
                      } else if (value.length < 6) {
                        return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'هل نسيت كلمة المرور؟',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => AppButton(
                        onPressed: () {
                          if (controller.loginFormKey.currentState
                                  ?.validate() ??
                              false) {
                            controller.login();
                          }
                        },
                        text: '',
                        child: controller.isLoading.value
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                "تسجيل الدخول",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Center(child: Text('- أو -')),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      // controller.loginWithFacebook();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.facebook, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'تسجيل الدخول باستخدام فيسبوك',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // controller.loginWithGoogle();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'تسجيل الدخول باستخدام جوجل',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
