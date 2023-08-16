
import 'package:gojek_university_app/utils/constants/font_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';

class InterestChipsWidget extends StatelessWidget {
  final List<String> interest;

  const InterestChipsWidget({super.key, required this.interest});

  @override
  Widget build(BuildContext context) {
    // Limit the number of items to show
    List<String> visibleItems = interest.take(6).toList();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.h,horizontal: 20.h),
      child: Wrap(
        spacing: 8.0.w, // horizontal spacing between chips
        runSpacing: 5.0.h, // vertical spacing between rows
        children: visibleItems
            .map(
              (item) => IntrinsicWidth(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: 27.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: MyColors.black, width: 2.w)),
              child: Center(
                child: Text(
                  item,
                  style: getBoldStyle(
                      fontSize: MyFonts.size9, color: MyColors.black,isMontserrat: true),
                ),
              ),
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}