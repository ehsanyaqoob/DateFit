import 'package:Dofit/utils/exports.dart';

import '../views/wellcome/wellcome_views.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToNext();
  }

  // Function to navigate to the next screen
  void navigateToNext() async {
    await Future.delayed(Duration(seconds: 4));
    Get.to(WelcomeView());
  }
}