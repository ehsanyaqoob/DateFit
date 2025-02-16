import 'package:Dofit/utils/exports.dart';

import '../views/home/navbar/home_view.dart';

class SignInController extends GetxController {
  // TextEditingControllers for input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observables for state management
  final RxBool isLoading = false.obs;

  // Function to validate email and password
  bool validateInput() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Email and password cannot be empty.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address.',
        backgroundColor: Colors.red,
        colorText: Colors.white,        snackPosition: SnackPosition.TOP,

      );
      return false;
    }

    return true;
  }

  // Sign-in process
  Future<void> signIn() async {
    if (!validateInput()) return;

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      // Success logic (navigate to home or dashboard)
      Get.to(()=> HomeView());
    } catch (error) {
      // Error handling
      Get.snackbar(
        'Sign In Failed',
        'Unable to sign in. Please try again later.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Dispose controllers
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
