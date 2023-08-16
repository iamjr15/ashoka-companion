import 'package:gojek_university_app/commons/common_imports/apis_commons.dart';
import 'package:gojek_university_app/commons/common_widgets/padding.dart';
import 'package:gojek_university_app/features/navigation_menu/controller/navigation_controller.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/constants/font_manager.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar(

      {Key? key, required this.subtitle, this.verticalPadding, required this.onBackTap,})
      : super(key: key);
  final String subtitle;
  final double? verticalPadding;
  final VoidCallback onBackTap;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical:verticalPadding?? 40.h),
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
               'my profile',
                style: getSemiBoldStyle(
                    fontSize: MyFonts.size20, color: MyColors.black),
              ),
              GestureDetector(
                  child: Image.asset(
                    AppAssets.menuIconNew,
                    height: 36.h,
                    width: 51.w,
                  )),
            ],
          ),
          padding20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
            child: Text(
              subtitle,
              style: getExtraBoldStyle(
                  fontSize: MyFonts.size16,
                  color: MyColors.newPinkColor
              ),
            ),
          ),
        ],
      ),
    );
  }
}
