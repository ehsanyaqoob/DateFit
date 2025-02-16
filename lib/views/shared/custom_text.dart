import 'package:Dofit/utils/exports.dart';

class CustomText extends Text {
  CustomText({
    super.key,
    String? text,
    TextAlign? textAlign,
    Color? color, double?
    fontSize, FontWeight?
    fontWeight, double?
    letterSpacing, TextDecoration?
    textDecoration, TextDecorationStyle?
    textDecorationStyle,
    Color? decorationColor,
    int? maxlines,
    String? font,
    TextOverflow? overflow,
  }) : assert(text != null, "Text is required"),
        super(
        text!,
        textAlign: textAlign ?? TextAlign.left,
        style: TextStyle(
          color: color ?? AppColors.black,
          fontFamily: font ?? AppFonts.poppins,
          fontSize: fontSize ?? 9,
          fontWeight: fontWeight ?? FontWeight.normal,
          letterSpacing: letterSpacing,
          decoration: textDecoration,
          decorationStyle: textDecorationStyle,
          decorationColor: decorationColor,
        ),
      );
}
