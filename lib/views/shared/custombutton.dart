import 'package:Dofit/utils/exports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
        required this.title,
        this.onTap,
        this.topMargin = 0.0,
        this.fillColor = true});

  final String title;
  final VoidCallback? onTap;
  final double topMargin;
  final bool fillColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: topMargin),
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.h/2),
            border: Border.all(
              color: AppColors.white,
            ),
            color: fillColor
                ? onTap == null
                ? Colors.grey
                : AppColors.primaryColor
                : Colors.white,
          ),
          child: Center(
            child: CustomText(
              text: title,
              textAlign: TextAlign.center,
              color: fillColor ? AppColors.white : AppColors.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}

