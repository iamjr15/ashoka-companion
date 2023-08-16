import 'package:gojek_university_app/commons/common_widgets/common_outline_border_button.dart';

import '../../../commons/common_imports/common_libs.dart';

class InterestWidget extends StatelessWidget {
  final String interestName;
  const InterestWidget({
    super.key,
    required this.interestName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CommonOutlineBorderButton(
          buttonText: interestName,
          onTap: (){},
        width: interestName.length * 15,
        height: 30.h,
        borderWidth: 1,
        insideColor: MyColors.white,
      ),
    );
  }
}
