
import 'package:Dofit/utils/exports.dart';


class CustomTextFormField extends StatelessWidget {
  TextEditingController? controller;
  String hint;
  String title;
  TextInputType? inputType;
  List<TextInputFormatter>? inputFormatters;
  Widget? prefix;
  ValueChanged<String>? onChanged;
  bool? isObscure;
  VoidCallback? onTap;
  String? errorText;
  bool? readOnly;
  bool? autoFocus;
  Widget? suffix;
  double? topPadding;
  TextAlign textAlign;
  TextCapitalization textCapitalization;
  TextInputAction textInputAction;
  ValueChanged? onSubmitted;
  VoidCallback? onSearch;

  CustomTextFormField(
      {super.key,
        this.title = '',
        required this.hint,
        this.controller,
        this.inputType = TextInputType.text,
        this.inputFormatters,
        this.prefix,
        this.onChanged,
        this.isObscure,
        this.onTap,
        this.errorText,
        this.readOnly,
        this.autoFocus,
        this.suffix,
        this.topPadding,
        this.textAlign = TextAlign.left,
        this.textCapitalization = TextCapitalization.none,
        this.textInputAction = TextInputAction.next,
        this.onSubmitted, this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: title != '',
            child: CustomText(
                text: title,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.brown),
          ),
          title != '' ? SizedBox(height: 4) : SizedBox(height: 0),
          Stack(
            children: [
              TextFormField(
                textInputAction: textInputAction,
                textCapitalization: textCapitalization,
                controller: controller,
                keyboardType: inputType ?? TextInputType.text,
                inputFormatters: inputFormatters ?? [],
                cursorColor: AppColors.primaryColor,
                autofocus: autoFocus ?? false,
                textAlign: textAlign,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onFieldSubmitted: onSubmitted,
                decoration: InputDecoration(
                  hintText: hint,
                  prefixIcon: prefix,
                  suffixIcon: suffix,
                  fillColor: AppColors.white,
                  filled: true,
                  errorText: errorText,
                  errorStyle: TextStyle(
                    color: AppColors.red,
                    fontSize: 10.sp,
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: TextStyle(
                    color: AppColors.blackGrey,
                    fontSize: 12.sp,
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w400,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    BorderSide(width: 1.5, color: AppColors.primaryColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1.5, color: AppColors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1.5, color: AppColors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    BorderSide(width: 1.5, color: AppColors.greyColor),
                  ),
                  isDense: true,
                ),
                readOnly: readOnly ?? false,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 14.sp,
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w400,
                ),
                onChanged: onChanged,
                onTap: onTap,
                obscureText: isObscure ?? false,
              ),
              Visibility(
                visible: onSearch == null ? false : true,
                child: Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: onSearch,
                    child: Container(
                      width: 120,
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(40 / 2))),
                      child: Center(
                          child: CustomText(
                              text: 'Search',
                              color: Colors.white,
                              font: AppFonts.poppins,
                              fontSize: 10.sp)),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class TextFieldIcon extends StatelessWidget {
  String icon;
  Color color;
  TextFieldIcon({super.key, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      padding: EdgeInsets.all(12),
      child: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}

