import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

/// We are using this widget class inside the Resource screen.
/// Its responsible for a single resource card.
class ResourcesWidget extends StatelessWidget {
  const ResourcesWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.imageColor,
    required this.onTap,
    required this.index,
  });
  final String title;
  final String imagePath;
  final int index;
  final Color imageColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 371.w,
        height: 154.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  boxShadow: index == 0 ? null: [
                    BoxShadow(
                        color: MyColors.secondaryTextColor.withOpacity(0.1),
                        offset: Offset(2.w, 1.h),
                        blurRadius: 20),
                    BoxShadow(
                        color: MyColors.black.withOpacity(0.1),
                        offset: Offset(-1.w, -1.h),
                        blurRadius: 20),
                  ]
              ),
              child: Image.asset(
                imagePath,
                height: 154.h,
                width: 370.w,
                fit: BoxFit.fill,
                color: imageColor,
              ),
            ),
            Container(
              width: 330.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title, style: getBoldStyle(
                    color: MyColors.white,
                    fontSize: MyFonts.size18

                  ),),
                  Image.asset(AppAssets.arrowNext, width: 28.w, height: 28.h,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}