import 'package:Dofit/utils/exports.dart';

import '../home/navbar/search_view.dart';


class HomeAppBar extends StatelessWidget {
  final String userName;
  final bool showGreeting;

  const HomeAppBar({
    Key? key,
    required this.userName,
    this.showGreeting = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// 🔹 Left Side (Greeting Text)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Hello, $userName',
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              if (showGreeting) ...[
                const SizedBox(height: 5),
                CustomText(
                  text: 'Manage your payments easily!',
                    fontSize: 14,
                    color: Colors.grey[600],
                
                  //overflow: TextOverflow.ellipsis,
                ),
              ]
            ],
          ),
        ),

        /// 🔹 Right Side (Search, Notification, Profile)
        Row(
          children: [
            /// Search Button -> Move to Search Screen
            IconButton(
              icon: const Icon(Icons.search, color: AppColors.primaryColor, size:30,),
              onPressed: () => Get.to(SearchScreen()),
            ),
         
          ],
        ),
      ],
    );
  }
}
