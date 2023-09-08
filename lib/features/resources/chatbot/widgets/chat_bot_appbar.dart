import 'package:gojek_university_app/commons/common_widgets/padding.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import '../../../../commons/common_imports/common_libs.dart';

class ChatBotAppBar extends StatelessWidget {
  const ChatBotAppBar({
    Key? key,
    this.verticalPadding,
    required this.onBackTap,
  }) : super(key: key);
  final double? verticalPadding;
  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 30.w, vertical: verticalPadding ?? 40.h),
      child: Column(
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
                  width: 38.w,
                  height: 38.h,
                ),
              ),
              Text(
                'ashoka assist',
                style: getSemiBoldStyle(
                    fontSize: MyFonts.size20, color: MyColors.black),
              ),
              Container(
                width: 40,
              )
              // GestureDetector(
              //     child: Image.asset(
              //   AppAssets.menuIconNew,
              //   height: 36.h,
              //   width: 51.w,
              // )),
            ],
          ),
          // padding20,
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
          //   child: Text(
          //     subtitle,
          //     style: getExtraBoldStyle(
          //         fontSize: MyFonts.size16,
          //         color: MyColors.newPinkColor
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
