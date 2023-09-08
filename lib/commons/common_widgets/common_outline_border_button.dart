import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/loading.dart';

import '../common_imports/common_libs.dart';

class CommonOutlineBorderButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? insideColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool isLoading;
  final String buttonText;
  final double? fontSize;
  final VoidCallback onTap;
  const CommonOutlineBorderButton(
      {Key? key,
      this.height,
      this.width,
      this.insideColor,
      this.isLoading = false,
      this.borderColor,
      this.borderWidth,
      required this.buttonText,
      this.fontSize,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100.r),
      child: Container(
        height: height ?? 54.h,
        width: width ?? 273.w,
        decoration: BoxDecoration(
          color: insideColor ?? MyColors.yellowLightGradientColor,
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(
              color: borderColor ?? MyColors.black, width: borderWidth ?? 3.w),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? const LoadingWidget(
                color: MyColors.black,
              )
            : Text(
                buttonText,
                style: getMediumStyle(
                  fontSize: fontSize ?? MyFonts.size14,
                ),
              ),
      ),
    );
  }
}
