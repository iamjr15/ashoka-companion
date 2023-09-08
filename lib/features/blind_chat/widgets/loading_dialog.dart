

import 'package:gojek_university_app/utils/constants/app_constants.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/loading.dart';

import '../../../commons/common_imports/common_libs.dart';

class LoadingProgressDialog extends StatelessWidget {
  const LoadingProgressDialog({
    super.key, required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(AppConstants.padding),
        decoration: BoxDecoration(
          color:MyColors.newPinkColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: MyColors.newPinkColor..withOpacity(0.1),
              // spreadRadius: 12,
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],

        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 32.h,
            ),
            Text(
              '$text. \nKindly Wait',
              textAlign: TextAlign.center,
              style: getRegularStyle(
                  color: Colors.white,
                  fontSize: MyFonts.size16),
            ),
            SizedBox(
              height: 20.h,
            ),
            const LoadingWidget(color: Colors.white,),
            SizedBox(
              height: 32.h,
            ),
          ],
        ),
      ),
    );
  }
}