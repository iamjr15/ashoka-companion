import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/constants/font_manager.dart';


/// We are using this Widget Class in the Side Navigation Menu Bar.
class NavigationPageTile extends StatelessWidget {
  final String pageName;
  final String iconPath;
  final bool isShowIcon;
  final VoidCallback onPageTap;
  const NavigationPageTile(
      {Key? key,
      required this.pageName,
      required this.iconPath,
      required this.onPageTap,
      this.isShowIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPageTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 40.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              pageName,
              style: getSemiBoldStyle(
                color: MyColors.textColor,
                fontSize: MyFonts.size18,
              ),
            ),

            if(isShowIcon)...[
              SizedBox(width: 25.w,),
              Image.asset(iconPath, height: 26.h, width: 26.w,)
            ]
          ],
        ),
      ),
    );
  }
}
