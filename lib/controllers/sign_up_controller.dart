import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:Dofit/utils/exports.dart';

class SignUpController extends GetxController {
  // Controllers for the input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController funnyQuestionController = TextEditingController();

  // Reactive values
  final RxString selectedGender = ''.obs;

  // Validation logic for sign-up form
  bool validateFields() {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter your name");
      return false;
    }
    if (phoneController.text.trim().isEmpty || phoneController.text.trim().length < 10) {
      Get.snackbar("Error", "Please enter a valid phone number");
      return false;
    }
    if (emailController.text.trim().isEmpty || !GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar("Error", "Please enter a valid email address");
      return false;
    }
    if (passwordController.text.trim().isEmpty || passwordController.text.trim().length < 6) {
      Get.snackbar("Error", "Password must be at least 6 characters long");
      return false;
    }
    if (selectedGender.value.isEmpty) {
      Get.snackbar("Error", "Please select your gender");
      return false;
    }
    if (countryController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter your country");
      return false;
    }
    if (funnyQuestionController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please answer the funny question");
      return false;
    }
    return true;
  }

  // Function to handle sign-up
  void signUp() {
    if (validateFields()) {
      // Perform sign-up logic
      Get.snackbar("Success", "Sign-up successful! Welcome, ${nameController.text.trim()}");
      
      // Clear fields after successful sign-up
      clearFields();
    }
  }

  // Clear all text fields and reset values
  void clearFields() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    countryController.clear();
    funnyQuestionController.clear();
    selectedGender.value = '';
  }

  // Dispose of controllers to avoid memory leaks
  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    countryController.dispose();
    funnyQuestionController.dispose();
    super.onClose();
  }
}
