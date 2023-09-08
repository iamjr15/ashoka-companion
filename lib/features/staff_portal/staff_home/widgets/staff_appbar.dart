import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/constants/font_manager.dart';

class StaffAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onBackTap;
  final VoidCallback onMenuTap;
  const StaffAppBar({Key? key, required this.title, required this.onBackTap, required this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onBackTap,
              child: Image.asset(
                AppAssets.backArrowNew,
                width: 46.w,
                height: 46.h,
              ),
            ),
            GestureDetector(
                onTap: onMenuTap,
                child: Image.asset(
                  AppAssets.menuIconNew,
                  height: 36.h,
                  width: 51.w,
                )),
          ],
        ),
        SizedBox(height: 32.h,),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.0.w),
          child: Text(title,
              style: getExtraBoldStyle(
                  fontSize: MyFonts.size16,
                  color: MyColors.newBlueColor,
                  isMontserrat: true)),
        ),

      ],
    );
  }
}
