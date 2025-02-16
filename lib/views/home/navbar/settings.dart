import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Dofit/utils/exports.dart';

class SettingsController extends GetxController {
  var userName = "John Doe".obs;
  var userEmail = "john.doe@example.com".obs;
  var profileImage = "".obs;

  void pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      profileImage.value = pickedFile.path;
    }
    Get.back(); // Close bottom sheet after selection
  }

  void deleteImage() {
    profileImage.value = ""; // Remove the image
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.put(SettingsController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              children: [
                Obx(() => Column(
                      children: [
                        GestureDetector(
                          onTap: () => _showImagePicker(context, controller),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[300], // Solid Background
                            backgroundImage: controller.profileImage.value.isNotEmpty
                                ? Image.asset(controller.profileImage.value).image
                                : const AssetImage("assets/png/Ellipse.png"),
                            child: controller.profileImage.value.isEmpty
                                ? const Icon(Icons.camera_alt, size: 30, color: Colors.white)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Delete Image Button
                        if (controller.profileImage.value.isNotEmpty)
                          TextButton(
                            onPressed: controller.deleteImage,
                            child: const Text(
                              "Remove Photo",
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          ),
                      ],
                    )),
                const SizedBox(height: 10),
                Obx(() => Text(controller.userName.value,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                Obx(() => Text(controller.userEmail.value,
                    style: const TextStyle(fontSize: 16, color: Colors.grey))),
                const SizedBox(height: 20),

                // Settings Options
                ListView(
                  shrinkWrap: true, // Prevents overflow
                  physics: const NeverScrollableScrollPhysics(), // Disable scrolling inside
                  children: [
                    _settingsOption(Icons.person, "Edit Profile", () {}),
                    _settingsOption(Icons.security, "Privacy & Security", () {}),
                    _settingsOption(Icons.notifications, "Notifications", () {}),
                    _settingsOption(Icons.language, "Language", () {}),
                    _settingsOption(Icons.help, "Help & Support", () {}),
                    _settingsOption(Icons.logout, "Logout", () {
                      // Handle logout
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _settingsOption(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 16, ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey, width: 1.5),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showImagePicker(BuildContext context, SettingsController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.brown),
              title: const Text("Capture from Camera"),
              onTap: () => controller.pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.brown),
              title: const Text("Choose from Gallery"),
              onTap: () => controller.pickImage(ImageSource.gallery),
            ),
            if (controller.profileImage.value.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text("Remove Photo", style: TextStyle(color: Colors.red)),
                onTap: controller.deleteImage,
              ),
          ],
        ),
      ),
    );
  }
}
