import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/models/auth/login_model.dart';
import '../../../data/repositories/auth/login_repository.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  // Form key for validation
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable variables
  final isLoading = false.obs;
  // For password visibility toggle
  final isPasswordVisible = false.obs;

  final repository = LoginRepository();

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() async {
    final storage = GetStorage();
    // Check if form is valid before proceeding
    if (!loginFormKey.currentState!.validate()) {
      return;
    }
    isLoading.value = true;
    final userData = LoginModel(
      email: emailController.text,
      password: passwordController.text,
    );

    try {
      final response = await repository.loginUser(userData);
      final token = response.data['token'];
      // print("Token: $token");
      await storage.write('token', token);
    Get.snackbar("نجاح", "تم تسجيل الدخول بنجاح!");
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
