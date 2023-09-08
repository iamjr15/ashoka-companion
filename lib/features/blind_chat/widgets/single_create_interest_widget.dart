import 'package:gojek_university_app/commons/common_widgets/common_outline_border_button.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/CustomTextFields.dart';

class CreateSingleTitlePriceWidget extends StatelessWidget {
  const CreateSingleTitlePriceWidget({
    super.key,
    required this.titleCtr,
    required this.onPress,
    required this.formKey,
  });

  final TextEditingController titleCtr;
  final Function() onPress;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Form(
            key: formKey,
            child: SizedBox(
              width: 110.w,
              height: 75.h,
              child: CustomTextField(
                controller: titleCtr,
                onChanged: (val) {},
                onFieldSubmitted: (val) {},
                hintText: 'type interest',
                obscure: false,
                texfieldHeight: 55.h,
                label: 'interest',
                showLabel: false,

              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        CommonOutlineBorderButton(
          onTap:  onPress,
          buttonText: 'Add',
          height: 35.h,
          width: 50.w,
          fontSize: MyFonts.size12,
          borderWidth: 1,
        )
      ],
    );
  }
}