import 'package:gojek_university_app/commons/common_widgets/common_outline_border_button.dart';

import '../../../commons/common_imports/common_libs.dart';

class InterestTileListWIdget extends StatelessWidget {
  const InterestTileListWIdget({
    super.key,
    required this.interestsList,
  });

  final List<String> interestsList;

  @override
  Widget build(BuildContext context) {
    List<String> interests = [];
    for (var interest in interestsList) {
      interests.add("$interest");
    }
    return Wrap(
      children: List.generate(interests.length, (index) => Padding(
        padding: EdgeInsets.only(left: 10.w, bottom: 15.h
        ),
        child: CommonOutlineBorderButton(
          buttonText: interests[index],
          onTap: (){},
          width: interests[index].length * 15,
          height: 30.h,
          borderWidth: 1,
          insideColor: MyColors.white,
        ),
      )
      ),
    );
  }
}