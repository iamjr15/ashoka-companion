import 'package:gojek_university_app/utils/constants/assets_manager.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/constants/font_manager.dart';

class RuleTile extends StatelessWidget {
  final String ruleText;
  const RuleTile({Key? key, required this.ruleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 22.h),
      child: Row(
        children: [
          Image.asset(
            AppAssets.checkCircleImageNew,
            height: 20.h,
            width: 20.w,
          ),
          SizedBox(
            width: 15.w,
          ),
          Text(
            ruleText,
            style: getBoldStyle(fontSize: MyFonts.size14),
          ),
        ],
      ),
    );
  }
}
