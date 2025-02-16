import 'package:Dofit/utils/app_constants.dart';
import 'package:Dofit/utils/exports.dart';
import 'package:Dofit/views/shared/custombutton.dart';

import '../../utils/app_assets.dart';
import '../home/navbar/navbar.dart';


class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.scaffoldBackgroundColor,
              AppColors.scaffoldBackgroundColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo at the top
            Padding(
              padding: EdgeInsets.only(top: 80.h),
              child: Hero(
                tag: "app_logo",
                child: SvgPicture.asset(
                  AppAssets.logo,
                  height: 250.h,
                  width: 250.w,
                ),
              ),
            ),

            // Bottom section: App description and button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                // App Description
                CustomText(
                  text: "Welcome to ${AppConstants.appName}",
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  text:
                      "Your smart companion for scanning dates and food items with ease and precision!",
                  fontSize: 16.sp,
                  textAlign: TextAlign.center,
                ),

                CustomButton(
                  title: 'Login',
                  onTap: () {
                    Get.to(SignInView());
                  },
                  fillColor: true,
                  topMargin: 20,
                ),
                CustomButton(
                  title: 'Signup',
                  onTap: () {
                    Get.to(SignUpView());
                  },
                  fillColor: true,
                  topMargin: 20,
                ),

                // "Get Started" Button
                CustomButton(
                  title: 'Exlpore as a guest',
                  onTap: () {
                    Get.to(ModernBottomNavBar());
                  },
                  topMargin: 20,
                  fillColor: false,
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
