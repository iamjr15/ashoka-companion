import 'package:gojek_university_app/commons/common_imports/apis_commons.dart';
import 'package:gojek_university_app/commons/common_widgets/padding.dart';
import 'package:gojek_university_app/features/navigation_menu/controller/navigation_controller.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/constants/font_manager.dart';

class InnerScreensAppBar extends StatelessWidget {
  const InnerScreensAppBar(

      {Key? key, required this.title, this.verticalPadding, required this.onBackTap,})
      : super(key: key);
  final String title;
  final double? verticalPadding;
  final VoidCallback onBackTap;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: verticalPadding?? 40.h,),
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
                title,
                style: getSemiBoldStyle(
                    fontSize: MyFonts.size20, color: MyColors.black),
              ),
              SizedBox(),
            ],
          ),

        ],
      ),
    );
  }
}
