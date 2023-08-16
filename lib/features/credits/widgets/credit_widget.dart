import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

/// We are using this widget in the Credits Screen.
class CreditWidget extends StatelessWidget {
  const CreditWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
    required this.subtitle, required this.smallSubTitle,
  });
  final String title;
  final String subtitle;
  final String smallSubTitle;
  final String imagePath;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(23.h),
      margin: EdgeInsets.symmetric(vertical: 25.h),
      decoration: BoxDecoration(
          color: MyColors.newLightGreyColor,
          borderRadius: BorderRadius.circular(15.r),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32.r,
            child: Image.asset(
              imagePath,
              width: 65.w,
              height: 65.h,
            ),
          ),
          SizedBox(
            width: 18.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 213.w
                ),
                child: Text(
                  title,
                  style:
                  getSemiBoldStyle(fontSize: MyFonts.size20, color: MyColors.black),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                smallSubTitle,
                style: getMediumStyle(
                    fontSize: MyFonts.size12, color: MyColors.newTextBlackSecondaryColor),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                subtitle,
                style: getMediumStyle(
                    fontSize: MyFonts.size12, color: MyColors.newTextBlackSecondaryColor),
              )
            ],
          )
        ],
      ),
    );
  }
}
