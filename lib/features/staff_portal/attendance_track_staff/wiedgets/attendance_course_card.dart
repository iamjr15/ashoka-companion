import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';

class AttendanceCourseCard extends StatelessWidget {
  const AttendanceCourseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      splashColor: MyColors.white,
      highlightColor: MyColors.white,
      onTap: (){
        Navigator.pushNamed(context, AppRoutes.staffCaptureAttendenceScreen);
      },
      child: Container(
        height: 122.h,
        constraints: BoxConstraints(
          minWidth: 358.w
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        margin: EdgeInsets.only(bottom: 28.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: MyColors.white,
          boxShadow: [
            BoxShadow(
              color: MyColors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 4)
            ),
            BoxShadow(
              color: MyColors.white.withOpacity(0.25),
              blurRadius: 4,
            ),
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cohort Introduction', style: getMediumStyle(
                  isMontserrat: true,
                  fontSize: MyFonts.size18
                ),),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 230.w
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_rounded, size: 18.sp,),
                          SizedBox(width: 10.w,),
                          Text('GJ04-003', style: getSemiBoldStyle(
                              isMontserrat: true,
                              color: MyColors.newTextBlackSecondaryColor,
                              fontSize: MyFonts.size16
                          ),),
                        ],
                      ),
                      Text('11:00 am', style: getSemiBoldStyle(
                          isMontserrat: true,
                          color: MyColors.newTextBlackSecondaryColor,
                          fontSize: MyFonts.size16
                      ),),
                    ],
                  ),
                )
              ],
            ),
            Image.asset(AppAssets.arrowStaff, width: 25.w, height: 28.h,)
          ],
        ),
      ),
    );
  }
}
