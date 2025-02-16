import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:Dofit/utils/exports.dart';

class SearchController extends GetxController {
  var isLoading = true.obs;
  var searchResults = [
    {'icon': Icons.date_range_sharp, 'title': 'Scan Dates'},
    {'icon': Icons.shopping_cart, 'title': 'Products'},
    {'icon': Icons.history, 'title': 'Recent Scans'},
    {'icon': Icons.folder, 'title': 'All Items'},
  ].obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
    });
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SearchController controller = Get.put(SearchController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Dofit Search", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.brown),
                hintText: "Search items...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => controller.isLoading.value
                ? _buildShimmerEffect()
                : _buildSearchResults(controller)),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Column(
      children: List.generate(4, (index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildSearchResults(SearchController controller) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.searchResults.length,
        itemBuilder: (context, index) {
          final item = controller.searchResults[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(item['icon'] as IconData?, color: Colors.brown),
              title: Text(item['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}
