import 'package:gojek_university_app/commons/common_functions/url_launch.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/utils/constants/app_constants.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

class FinishChatInstaWidget extends StatelessWidget {
  const FinishChatInstaWidget({
    super.key,
    required this.instaId,
  });
  final String instaId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 334.w,
        height: 229.h,
        padding: EdgeInsets.all(20.h),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
            color: MyColors.finishChatInstaWidgetColor,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                  color: MyColors.secondaryTextColor.withOpacity(0.2),
                  offset: Offset(2.w, 1.h),
                  blurRadius: 12),
              BoxShadow(
                  color: MyColors.white.withOpacity(0.1),
                  offset: Offset(-1.w, -1.h),
                  blurRadius: 12),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'keep on the \nconversation on \ninstagram',
              style:
                  getSemiBoldStyle(fontSize: MyFonts.size30, color: MyColors.black,isMontserrat: true),
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                Image.asset(
                  AppAssets.instaLogo,
                  width: 19.w,
                  height: 19.h,
                  color: MyColors.black,
                ),
                SizedBox(width: 10.w,),
                InkWell(
                  onTap: (){
                     launchURL(Url: "https://instagram.com/$instaId");
                  },
                  child: Text(
                    instaId,
                    style: getMediumStyle(
                        fontSize: MyFonts.size16, color: MyColors.black,isMontserrat: true),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}