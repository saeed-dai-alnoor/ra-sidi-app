import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/views/widgets/app_button.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    final FocusNode nameFocus = FocusNode();
    final FocusNode emailFocus = FocusNode();
    final FocusNode passwordFocus = FocusNode();

    // ستايل البوردر البرتقالي
    final orangeBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.orange, width: 2),
      borderRadius: BorderRadius.circular(8),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: controller.signUpFormKey, // المفتاح الخاص بالفورم
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "إنشاء حساب جديد",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // حقل الاسم
                  TextFormField(
                    controller: controller.nameController,
                    focusNode: nameFocus,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(emailFocus);
                    },
                    decoration: InputDecoration(
                      border: orangeBorder,
                      enabledBorder: orangeBorder,
                      focusedBorder: orangeBorder,
                      labelText: 'الاسم',
                      labelStyle: TextStyle(color: Colors.grey[600]),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك أدخل الاسم';
                      } else if (value.length < 2) {
                        return 'يجب أن يكون الاسم على الأقل حرفين';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // حقل البريد الإلكتروني
                  TextFormField(
                    controller: controller.emailController,
                    focusNode: emailFocus,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                    decoration: InputDecoration(
                      border: orangeBorder,
                      enabledBorder: orangeBorder,
                      focusedBorder: orangeBorder,
                      labelText: 'البريد الإلكتروني',
                      labelStyle: TextStyle(color: Colors.grey[600]),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك أدخل البريد الإلكتروني';
                      } else if (!GetUtils.isEmail(value)) {
                        return 'من فضلك أدخل بريد إلكتروني صحيح';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // حقل كلمة المرور
                  Obx(
                    () => TextFormField(
                      controller: controller.passwordController,
                      focusNode: passwordFocus,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.done,
                      obscureText: !controller.isPasswordVisible.value,
                      decoration: InputDecoration(
                        border: orangeBorder,
                        enabledBorder: orangeBorder,
                        focusedBorder: orangeBorder,
                        labelText: 'كلمة المرور',
                        labelStyle: TextStyle(color: Colors.grey[600]),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey[600],
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أدخل كلمة المرور';
                        } else if (value.length < 6) {
                          return 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 40),

                  // زر التسجيل
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: Obx(
                      () => AppButton(
                        onPressed: () {
                          if (controller.signUpFormKey.currentState
                                  ?.validate() ??
                              false) {
                            controller.signup();
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
                                "إنشاء الحساب",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
