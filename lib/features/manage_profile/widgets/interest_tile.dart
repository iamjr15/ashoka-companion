import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../controllers/manage_interests_controller.dart';


class InterestTile extends StatelessWidget {
  final String interestName;
  final VoidCallback onTap;
  const InterestTile(
      {Key? key,
        required this.interestName,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final manageInterestCtr = ref.watch(manageInterestsController);
        bool isSelected =  manageInterestCtr.selectedInterests.contains(interestName);
        bool isSmall =  interestName.length < 4;
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100.r),
          splashColor: MyColors.transparentColor,
          highlightColor: MyColors.transparentColor,
          child: Container(
            height: 45.h,
            width: isSmall ? 75.w : interestName.length * 15,
            margin: EdgeInsets.only(right: 14.w, bottom: 16.h),
            decoration: BoxDecoration(
              color: isSelected ? MyColors.authBgColor : MyColors.white,
              borderRadius: BorderRadius.circular(25.r),
              border: Border.all(
                  color: isSelected ? MyColors.newYellowColor : MyColors.newTextBlackSecondaryColor,
                  width: isSelected ? 2.w : 1.w),
            ),
            alignment: Alignment.center,
            child: Text(
              interestName,
              style: getMediumStyle(
                fontSize: MyFonts.size20,
                color: isSelected ? MyColors.newYellowColor : MyColors.newTextBlackSecondaryColor
              ),
            ),
          ),
        );
      },

    );
  }
}
