import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/font_manager.dart';

class CourseViewCard extends StatelessWidget {
  const CourseViewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 317,
        constraints: BoxConstraints(
          maxWidth: 349.w,
          maxHeight: 317.h
        ),
        decoration: BoxDecoration(
          color: MyColors.newLightGreyColor,
          borderRadius: BorderRadius.circular(12.r)
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cohort Introduction', style: getMediumStyle(
                    isMontserrat: true,
                    fontSize: MyFonts.size18
                ),),
                Text('11:00 am', style: getSemiBoldStyle(
                    isMontserrat: true,
                    color: MyColors.black,
                    fontSize: MyFonts.size16
                ),),
              ],
            ),
            SizedBox(height: 25.h,),
            Row(
              children: [
                Icon(Icons.location_on_rounded, size: 18.sp,color: MyColors.black,),
                SizedBox(width: 10.w,),
                Text('GJ04-003', style: getSemiBoldStyle(
                    isMontserrat: true,
                    color: MyColors.black,
                    fontSize: MyFonts.size16
                ),),
              ],
            ),
            SizedBox(height: 25.h,),
            Text('Total count', style: getRegularStyle(
                isMontserrat: true,
                color: MyColors.black,
                fontSize: MyFonts.size16
            ),),
            SizedBox(height: 12.h,),
            Text('125 students', style: getMediumStyle(
                isMontserrat: true,
                color: MyColors.black,
                fontSize: MyFonts.size18
            ),),
            SizedBox(height: 26.h,),
            Text('Last recorded', style: getRegularStyle(
                isMontserrat: true,
                color: MyColors.black,
                fontSize: MyFonts.size16
            ),),
            SizedBox(height: 12.h,),
            Text('11:59 PM', style: getMediumStyle(
                isMontserrat: true,
                color: MyColors.black,
                fontSize: MyFonts.size18
            ),),
          ],
        ),
      ),
    );
  }
}
