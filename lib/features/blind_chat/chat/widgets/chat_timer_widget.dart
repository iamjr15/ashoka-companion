
import 'package:gojek_university_app/commons/common_functions/secondsToMMSS.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

class ChatTimerWidget extends StatelessWidget {
  const ChatTimerWidget({
    super.key,
    required double progressValue,
  }) : _progressValue = progressValue;

  final double _progressValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 180.w,
        height: 36.h,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: MyColors.black, width: 3.w)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              widthFactor: _progressValue,
              child: Container(
                width: _progressValue,
                height: _progressValue < 20 ? 20.h : 36.h,
                decoration: BoxDecoration(
                  color: MyColors.yellowLightGradientColor,
                  borderRadius:
                  BorderRadius.circular(_progressValue < 20 ? 50.r : 18.r),
                ),
              ),
            ),
            Center(
              child: Text(
                secondsToMMSS(_progressValue.toInt()),
                style: getBoldStyle(
                    fontSize: MyFonts.size17, color: MyColors.black,isMontserrat: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}