import 'package:el_tooltip/el_tooltip.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

import '../../../commons/common_imports/common_libs.dart';

class OnlineBar extends StatelessWidget {
  final int numberOfOnlinePeople;
  const OnlineBar({Key? key, required this.numberOfOnlinePeople}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 241.w,
      height: 73.h,
      decoration: BoxDecoration(
        color: MyColors.onlineBarBackgroundColor,
          borderRadius: BorderRadius.circular(100.r),

      ),
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 30.w,
            height: 30.h,
            decoration: const BoxDecoration(
              color: MyColors.onlineColor,
              shape: BoxShape.circle,
            ),
          ),
          Text('$numberOfOnlinePeople', style: getSemiBoldStyle(
            color: MyColors.textColor,
            fontSize: MyFonts.size28
          ),),
        Tooltip(
            message: 'no. of people\n online right now',
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(6.r)
            ),
            textStyle: getMediumStyle(
              fontSize: MyFonts.size11
            ),
            margin: EdgeInsets.only(left: 120.w),
            preferBelow: false,
            triggerMode: TooltipTriggerMode.tap,
            enableFeedback: true,
            verticalOffset: 10,
            child: Container(
              width: 30.w,
              height: 30.h,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: MyColors.black,
                shape: BoxShape.circle,
              ),
              child: Text(
                'i',
                style: getBoldStyle(
                    fontSize: MyFonts.size16,
                    color: MyColors.yellowLightGradientColor
                ),),
            ),
        ),

        ],
      ),
    );
  }
}
