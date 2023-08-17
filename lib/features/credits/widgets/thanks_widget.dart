import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

/// Thank-you card, we are using it in the Credits Screen
class ThanksWidget extends StatelessWidget {
  const ThanksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: double.infinity,
      padding: EdgeInsets.all(20.h),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: MyColors.newLightPinkColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Special Thanks To:',
            style: getBoldStyle(
                fontSize: MyFonts.size12, color: MyColors.newPinkColor),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Mrs. Pooja Manaktala & the Office of Student Affairs',
            style: getRegularStyle(
                fontSize: MyFonts.size14, color: MyColors.newBlackColor),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Mrs. Anu Batra, Mr. Sunil Kataria & the Ashoka IT Team',
            style: getRegularStyle(
                fontSize: MyFonts.size14, color: MyColors.newBlackColor),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Mr. Saurabh Kumar',
            style: getRegularStyle(
                fontSize: MyFonts.size14, color: MyColors.newBlackColor),
          ),
        ],
      ),
    );
  }
}
