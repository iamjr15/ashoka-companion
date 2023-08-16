import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/utils/constants/app_constants.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

class AttendanceTrackerCard extends StatelessWidget {
  final VoidCallback onCardTap;
  const AttendanceTrackerCard({
    super.key, required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: MyColors.transparentColor,
      splashColor: MyColors.transparentColor,
      onTap: onCardTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.all(30.h),
        decoration: BoxDecoration(
            color: MyColors.newPinkColor,
            borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: MyColors.newYellowColor,
            width: 1.5.w
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Image.asset(
              AppAssets.attendanceTrackerIconNew,
              width: 62.w,
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'attendance tracker',
                  style:
                  getSemiBoldStyle(fontSize: MyFonts.size24, color: MyColors.white),
                ),
                Image.asset(AppAssets.arrowForwardNew,width:28.5 ,height: 25.2,)
               
              ],
            )
          ],
        ),
      ),
    );
  }
}

// CachedNetworkImage(
// imageUrl: personImg1,
// imageBuilder: (context, imageProvider) => Container(
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// image: DecorationImage(
// image: imageProvider, fit: BoxFit.fill),
// ),
// ),
// placeholder: (context, url) => Center(
// child: SizedBox(
// width: 30.w,
// height: 30.h,
// child: const CircularProgressIndicator())),
// errorWidget: (context, url, error) => Center(
// child: SizedBox(
// width: 30.w,
// height: 30.h,
// child: const Icon(Icons.error))),
// ),
