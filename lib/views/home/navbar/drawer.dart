import 'package:Dofit/utils/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primaryColor, 
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              CustomText(
                 text:  "Menu",
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                
                SizedBox(height: 8),
                CustomText(
                 text:  "Explore options",
                 
                    fontSize: 22.sp,
                    color: Colors.white.withOpacity(0.8),
                  
                ),
              ],
            ),
          ),
          _buildListTile(Icons.privacy_tip, "Privacy Policy", () {
            Navigator.pop(context);
            Get.to(() => PrivacyPolicyView());
          }),
          _buildListTile(Icons.brightness_6, "Dark/Light Mode", () {
            Navigator.pop(context);
            Get.to(() => DarkLightModeView());
          }),
          _buildListTile(Icons.feedback, "Feedback", () {
            Navigator.pop(context);
            Get.to(() => FeedbackView());
          }),
          _buildListTile(Icons.logout, "Logout", () {
            Navigator.pop(context);
            Get.to(() => LogoutView());
          }),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.green), // Change to AppColors.primaryColor
      title: Text(title),
      onTap: onTap,
    );
  }
}

// 📌 Privacy Policy View
class PrivacyPolicyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy Policy")),
      body: Center(child: Text("Privacy Policy Content Goes Here")),
    );
  }
}

// 📌 Dark/Light Mode View
class DarkLightModeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dark/Light Mode")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
          },
          child: Text("Toggle Theme"),
        ),
      ),
    );
  }
}

// 📌 Feedback View
class FeedbackView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feedback")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Enter your feedback"),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Get.snackbar("Feedback Sent", "Thank you for your feedback!");
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

// 📌 Logout View
class LogoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Logout")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.offAllNamed("/login"); // Replace with actual login route
          },
          child: Text("Confirm Logout"),
        ),
      ),
    );
  }
}
