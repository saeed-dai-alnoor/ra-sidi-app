import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/models/auth/sign_up_model.dart';
import '../../../data/repositories/auth/signup_repository.dart';
import '../../../routes/app_pages.dart';

class SignUpController extends GetxController {
  // Form key for validation
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  // Text editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable variables
  final isLoading = false.obs;
  // For password visibility toggle
  final isPasswordVisible = false.obs;

  final repository = SignupRepository();
  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void signup() async {
    final storage = GetStorage();
    // Check if form is valid before proceeding
    if (!signUpFormKey.currentState!.validate()) {
      return;
    }
    isLoading.value = true;
    final userData = SignUpModel(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    try {
      final response = await repository.signupUser(userData);
      final token = response.data['token'];
      final name = response.data['name'];
      final email = response.data['email'];

      await storage.write('token', token);
      await storage.write('name', name);
      await storage.write('email', email);
      Get.snackbar("نجاح", "تم تسجيل المستخدم بنجاح!");
      Get.offAllNamed(Routes.HOME, arguments: {"name": name});
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
