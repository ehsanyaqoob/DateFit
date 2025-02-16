import 'package:Dofit/utils/exports.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_constants.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  final SplashController splashController = Get.put(SplashController());
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();

    _fadeInAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor.withOpacity(0.9),
              AppColors.primaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Fade-in effect for the logo
            FadeTransition(
              opacity: _fadeInAnimation,
              child: SvgPicture.asset(
                AppAssets.logo,
                height: 130.h,
                width: 130.w,
              ),
            ),
            SizedBox(height: 24.h),
            // App Name with animation
            FadeTransition(
              opacity: _fadeInAnimation,
              child: CustomText(
                text: AppConstants.appName,
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.h),
            // Animated tagline
            FadeTransition(
              opacity: _fadeInAnimation,
              child: CustomText(
                text: AppConstants.splashline,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 40.h),
            // Stylish Circular Progress Indicator
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 6.0,
              ),
            ),
            SizedBox(height: 50.h),
            // Footer Text with subtle animation
            FadeTransition(
              opacity: _fadeInAnimation,
              child: CustomText(
                text: "Powered by DoFit",
                fontSize: 14.sp,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
