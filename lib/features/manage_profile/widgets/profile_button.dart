
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

import '../../../commons/common_imports/common_libs.dart';

class MyProfileButton extends StatelessWidget {
  const MyProfileButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.buttonIcon,
  });
  final Function() onTap;
  final String buttonText;
  final String buttonIcon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // width: 352.w,
          // height: 89.h,
          margin: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 19.w,
          ),
          decoration: BoxDecoration(
            color: MyColors.newLightGreyColor,
            borderRadius: BorderRadius.circular(10.r)
          ),
          padding: EdgeInsets.symmetric(
              vertical: 33.h,
              horizontal: 30.w
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                buttonIcon,
                width: 24.w,
                height: 24.h,
              ),

              const Spacer(),
              Text(
                buttonText,
                style: getMediumStyle(
                    color: MyColors.black, fontSize: MyFonts.size16),
              ),
              const Spacer(),

              Image.asset(
                AppAssets.arrowStaff,
                width: 28.w,
                height: 24.h,
                color: MyColors.newPinkColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
