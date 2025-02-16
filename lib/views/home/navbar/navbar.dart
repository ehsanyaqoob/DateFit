import 'package:Dofit/utils/exports.dart';
import 'package:Dofit/views/home/navbar/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'home_view.dart';
import 'scanview.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

class ModernBottomNavBar extends StatelessWidget {
  final List<Widget> pages = [
    HomeView(),
    ScanView(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());

    return Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: SalomonBottomBar(
            currentIndex: controller.selectedIndex.value,
            onTap: (index) {
              if (index == 1) {
                Get.to(() => ScanView()); // Navigate to ScanView
              } else {
                controller.changeIndex(index);
              }
            },
            selectedItemColor: AppColors.primaryColor, // iOS-style tint
            unselectedItemColor: Colors.grey.shade500,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            curve: Curves.easeInOut,
            items: [
              _buildNavItem(
                icon: Icons.home,
                title: "Home",
                isSelected: controller.selectedIndex.value == 0,
              ),
              _buildNavItem(
                icon: Icons.qr_code_scanner,
                title: "Scan",
                isSelected: controller.selectedIndex.value == 1,
              ),
              _buildNavItem(
                icon: Icons.settings,
                title: "Settings",
                isSelected: controller.selectedIndex.value == 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SalomonBottomBarItem _buildNavItem(
      {required IconData icon, required String title, required bool isSelected}) {
    return SalomonBottomBarItem(
      icon: Icon(icon, size: isSelected ? 30 : 24),
      title: RichText(
        text: TextSpan(
          text: title,
          style: TextStyle(
            fontSize: isSelected ? 16 : 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? AppColors.primaryColor : Colors.grey.shade600,
          ),
        ),
      ),
      selectedColor: AppColors.primaryColor,
    );
  }
}
