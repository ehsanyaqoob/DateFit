import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class KhajoorScanner extends StatefulWidget {
  @override
  _KhajoorScannerState createState() => _KhajoorScannerState();
}

class _KhajoorScannerState extends State<KhajoorScanner> {
  MobileScannerController scannerController = MobileScannerController();
  File? _scannedImage;
  bool _isFlashOn = false;
  String _khajoorName = "No Khajoor Scanned";
  String _khajoorDetails = "Tap the scan button to start.";

  final Map<String, String> khajoorData = {
    "Ajwa": "Rich in antioxidants, good for heart health.",
    "Medjool": "Soft, caramel-like texture, natural sweetener.",
    "Barhi": "Very sweet, creamy, best eaten fresh.",
    "Safawi": "Dark brown, chewy, full of nutrients.",
    "Unknown": "Details not found! Try scanning again."
  };

  /// 📸 Pick an image from the gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _scannedImage = File(pickedFile.path);
        _khajoorName = "Manual Capture";
        _khajoorDetails = "Image captured manually. Unable to extract details.";
      });
    }
  }

  /// 🚀 Open Full-Screen Scanner
  void _openScanner() {
    Get.to(() => ScannerScreen(
          onDetect: (barcode) {
            if (barcode.isNotEmpty) {
              final String scannedData = barcode.first.rawValue ?? "Unknown";
              setState(() {
                _khajoorName = scannedData;
                _khajoorDetails = khajoorData[scannedData] ?? "No details available.";
              });
              Get.back(); // Close scanner after detection
            }
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 📷 Scanned Image Display
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                image: _scannedImage != null
                    ? DecorationImage(image: FileImage(_scannedImage!), fit: BoxFit.cover)
                    : const DecorationImage(image: AssetImage('assets/placeholder.png')),
              ),
            ),
            const SizedBox(height: 20),

            // 🏷 Khajoor Name
            Text(
              _khajoorName,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // 📜 Khajoor Details
            Text(
              _khajoorDetails,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),

      // 🚀 Floating Button to Start Scan
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.green.shade800,
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
                      onTap: () {
                        Navigator.pop(context);
                        _openScanner();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.camera_alt, color: Colors.white),
                      title: const Text("Capture Image", style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.image, color: Colors.white),
                      title: const Text("Select from Gallery", style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: Colors.green.shade700,
        child: const Icon(Icons.camera, color: Colors.white),
      ),
    );
  }
}

/// 📌 **Scanner Screen**
class ScannerScreen extends StatefulWidget {
  final Function(List<Barcode>) onDetect;
  const ScannerScreen({Key? key, required this.onDetect}) : super(key: key);

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  MobileScannerController scannerController = MobileScannerController();
  bool _isFlashOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: scannerController,
            onDetect: (capture) => widget.onDetect(capture.barcodes),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              icon: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off, color: Colors.white),
              onPressed: () {
                setState(() {
                  _isFlashOn = !_isFlashOn;
                  scannerController.toggleTorch();
                });
              },
            ),
          ),
          Positioned(
            bottom: 100,
            child: Text(
              "Align the QR code within the frame",
              style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
