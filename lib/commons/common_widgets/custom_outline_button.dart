import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/utils/loading.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.isLoading = false,
    this.backColor,
    this.textColor,
    this.buttonWidth,
    this.buttonHeight,
    this.fontSize,
  });
  final Function()? onPressed;
  final String buttonText;
  final bool isLoading;
  final Color? backColor;
  final Color? textColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: RawMaterialButton(
        elevation: 2,
        fillColor: backColor ?? Colors.transparent,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
            side: BorderSide(color: MyColors.secondaryTextColor, width: 1.w)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          width: buttonWidth ?? double.infinity,
          height: buttonHeight ?? 56.h,
          child: Center(
              child: isLoading
                  ? const LoadingWidget(
                      color: MyColors.themeColor,
                    )
                  : Text(
                      buttonText,
                      style: getMediumStyle(
                          color: textColor ?? MyColors.white,
                          fontSize: fontSize ?? 14.spMin),
                    )),
        ),
      ),
    );
  }
}
