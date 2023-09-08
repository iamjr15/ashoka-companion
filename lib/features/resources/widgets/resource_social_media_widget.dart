import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';


/// This was the widget class we made for old design.
class ResourceSocialMediaWidget extends StatelessWidget {
  const ResourceSocialMediaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 334.w,
      height: 101.h,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
                color: MyColors.secondaryTextColor.withOpacity(0.2),
                offset: Offset(2.w, 1.h),
                blurRadius: 12),
            BoxShadow(
                color: MyColors.white.withOpacity(0.1),
                offset: Offset(-1.w, -1.h),
                blurRadius: 12),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              radius: 28.r,
              backgroundColor: MyColors.fbColor,
              child: Center(
                child: Image.asset(
                  AppAssets.fbLogo,
                  width: 18.w,
                  height: 18.h,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              radius: 28.r,
              backgroundColor: MyColors.instaColor,
              child: Center(
                child: Image.asset(
                  AppAssets.instaLogo,
                  width: 18.w,
                  height: 18.h,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              radius: 28.r,
              backgroundColor: MyColors.twitterColor,
              child: Center(
                child: Image.asset(
                  AppAssets.twitterLogo,
                  width: 18.w,
                  height: 18.h,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}