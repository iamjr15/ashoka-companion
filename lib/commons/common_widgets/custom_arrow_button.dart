import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/loading.dart';

import '../../utils/constants/assets_manager.dart';

class CustomArrowButton extends StatelessWidget {
  const CustomArrowButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.isLoading = false,
    this.backColor,
    this.textColor,
    this.buttonWidth,
    this.buttonHeight,
    this.fontSize,
    this.padding,
    this.borderRadius, this.icon,
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
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight,
      margin: EdgeInsets.symmetric(vertical: padding ?? 10.h),
      child: RawMaterialButton(
        elevation: 2,
        fillColor: backColor ?? Theme.of(context).primaryColor,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 11.r),
        ),
        child: SizedBox(
          // padding: EdgeInsets.symmetric(vertical: 10.h),
          width: buttonWidth ?? double.infinity,
          height: buttonHeight ?? 56.h,
          child: Center(
              child: isLoading
                  ?  LoadingWidget(
                      color: textColor?? MyColors.white,
                    )
                  : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            buttonText,
                            style: getMediumStyle(
                                color: textColor ?? Colors.white,
                                fontSize: fontSize ?? MyFonts.size20),
                          ),
                          Image.asset(
                            icon??AppAssets.arrowForwardNew,
                            width: 25,
                            height: 28,
                            color: textColor ??Colors.white,
                          )
                        ],
                      ),
                  )),
        ),
      ),
    );
  }
}
