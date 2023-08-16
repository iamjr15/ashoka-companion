import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/loading.dart';

class SignInCustomButton extends StatelessWidget {
  const SignInCustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.isLoading = false,
    this.backColor,
    this.textColor,
    this.buttonWidth,
    this.buttonHeight,
    this.fontSize,
    this.padding, this.borderRadius,
  });
  final Function()? onPressed;
  final String buttonText;
  final bool isLoading;
  final Color? backColor;
  final Color? textColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? fontSize;
  final double? padding;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      child: RawMaterialButton(
        elevation: 2,
        fillColor: backColor ?? Theme.of(context).primaryColor,
        onPressed: onPressed,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius??20.r),
        ),
        child: SizedBox(
          // padding: EdgeInsets.symmetric(vertical: 10.h),
          width: buttonWidth ?? double.infinity,
          height: buttonHeight ?? 56.h,
          child: Center(
              child: isLoading
                  ? const LoadingWidget(
                color: MyColors.white,
              )
                  : Text(
                buttonText.toUpperCase(),
                style: getSemiBoldStyle(
                    color: textColor ?? Colors.white,
                    fontSize: fontSize ?? MyFonts.size20),
              )),
        ),
      ),
    );
  }
}
