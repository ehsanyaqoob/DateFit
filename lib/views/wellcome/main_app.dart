
import 'package:Dofit/utils/exports.dart';

import '../auth/splash_view.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: AppColors.white,
              appBarTheme: AppBarTheme(backgroundColor: AppColors.white)),
          title: 'Kupa',
          home: SplashView(),
        );
      },
    );
  }
}
