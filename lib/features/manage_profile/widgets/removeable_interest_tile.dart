import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../controllers/manage_interests_controller.dart';


class RemoveableInterestTile extends StatelessWidget {
  final String interestName;
  final VoidCallback onTap;
  const RemoveableInterestTile(
      {Key? key,
        required this.interestName,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final manageInterestCtr = ref.watch(manageInterestsController);
        bool isVerySmall =  interestName.length <= 2;
        bool isSmall =  interestName.length <= 5;
        bool isLarge =  interestName.length >= 14;
        bool isMedium = interestName.length <= 5 || interestName.length >= 14;
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100.r),
          splashColor: MyColors.transparentColor,
          highlightColor: MyColors.transparentColor,
          child: Container(
            height: 45.h,
            width:
            isVerySmall ? 80.w :
            isSmall ? interestName.length * 22 :
            isLarge ? interestName.length * 18 :
            isMedium ? interestName.length * 15:
            interestName.length * 18,
            margin: EdgeInsets.only(right: 14.w, bottom: 16.h),
            padding: EdgeInsets.only(left: 10.w, ),
            decoration: BoxDecoration(
              color: MyColors.authBgColor ,
              borderRadius: BorderRadius.circular(25.r),
              border: Border.all(
                  color: MyColors.newYellowColor ,
                  width: 2.w ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth:interestName.length > 24 ? 235.w: 300.w,
                  ),
                  child: Text(
                    interestName,
                    overflow: TextOverflow.ellipsis,
                    style: getMediumStyle(
                        fontSize: MyFonts.size20,
                        color: MyColors.newYellowColor
                    ),
                  ),
                ),
                Image.asset(AppAssets.crossIcon, width: 18.w, height: 18.h,)
              ],
            ),
          ),
        );
      },

    );
  }
}
