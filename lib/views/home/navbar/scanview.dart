import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ScanView extends StatefulWidget {
  @override
  _ScanViewState createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  final MobileScannerController scannerController = MobileScannerController();
  File? _scannedImage;
  String _khajoorName = "No Khajoor Scanned";
  String _khajoorDetails = "Tap the scan button to start.";

  final Map<String, String> khajoorData = {
    "Ajwa": "Rich in antioxidants, good for heart health.",
    "Medjool": "Soft, caramel-like texture, natural sweetener.",
    "Barhi": "Very sweet, creamy, best eaten fresh.",
    "Safawi": "Dark brown, chewy, full of nutrients.",
    "Unknown": "Details not found! Try scanning again."
  };

  /// 📸 Capture Image
  Future<void> _captureImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _scannedImage = File(pickedFile.path);
        _khajoorName = "Manual Capture";
        _khajoorDetails = "Image captured manually. Unable to extract details.";
      });
    }
  }

  /// 📌 On Detect QR Code
  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String scannedData = barcodes.first.rawValue ?? "Unknown";
      setState(() {
        _khajoorName = scannedData;
        _khajoorDetails = khajoorData[scannedData] ?? "No details available.";
      });
      Get.snackbar("Scanned", _khajoorName, backgroundColor: Colors.white, colorText: Colors.black);
      Get.back(); // Scanner Close
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(controller: scannerController, onDetect: _onDetect),

          // 🔙 Back Button
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),

          // ⚡ Flash Toggle
          Positioned(
            bottom: 50,
            child: IconButton(
              icon: const Icon(Icons.flash_on, color: Colors.white, size: 30),
              onPressed: () => scannerController.toggleTorch(),
            ),
          ),
        ],
      ),

      // 🚀 Floating Button for Options
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.brown.shade800,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              return SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.qr_code_scanner, color: Colors.white),
                      title: const Text("Scan QR Code", style: TextStyle(color: Colors.white)),
                      onTap: () => Get.to(() => ScanView()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.camera_alt, color: Colors.white),
                      title: const Text("Capture Image", style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context);
                        _captureImage();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: Colors.brown.shade700,
        child: const Icon(Icons.camera, color: Colors.white),
      ),

      // 📜 Scanned Details UI
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        height: 250,
        decoration: BoxDecoration(
          color: Colors.brown.shade900,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 📷 Image Display
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                image: _scannedImage != null
                    ? DecorationImage(image: FileImage(_scannedImage!), fit: BoxFit.cover)
                    : const DecorationImage(image: AssetImage('assets/placeholder.png')),
              ),
            ),
            const SizedBox(height: 10),

            // 🏷 Khajoor Name
            Text(
              _khajoorName,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),

            // 📜 Khajoor Details
            Text(
              _khajoorDetails,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
