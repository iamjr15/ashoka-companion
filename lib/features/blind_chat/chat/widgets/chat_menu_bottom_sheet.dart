import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gojek_university_app/commons/common_widgets/common_outline_border_button.dart';
import 'package:gojek_university_app/commons/common_widgets/custom_button.dart';
import 'package:gojek_university_app/features/navigation_menu/controller/navigation_controller.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/thems/styles_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';

Future<bool> chatMenu(BuildContext context) async {
  bool chatToElse= false;

  chatToElse = await showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    useRootNavigator: true,
    isScrollControlled: true,
    isDismissible: true,
    barrierColor: Colors.black45.withOpacity(0.8),
    elevation: 10,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      topLeft: Radius.circular(20),
    )),
    builder: (context) {
      return ChatMenuBottomSheet();
    },
  ).then((value){
    if(value==null){
      return false;  //if modalBottomSheet is closed dismissible so it will return false to handle error
    }
    return true;
  });
  return chatToElse;
}

class ChatMenuBottomSheet extends StatefulWidget {
  const ChatMenuBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatMenuBottomSheet> createState() => _ChatMenuBottomSheetState();
}

class _ChatMenuBottomSheetState extends State<ChatMenuBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 12.h,
        ),
        Container(
          height: 4.h,
          width: 54.w,
          decoration: BoxDecoration(
            color: MyColors.newTextFieldColor,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Center(
          child: CustomButton(
            buttonText: 'chat to someone else',
            onPressed: () {
              Navigator.pop(context,true);
            },
            buttonWidth: 318.w,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
