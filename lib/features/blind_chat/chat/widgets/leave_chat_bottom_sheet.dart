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

Future<bool> leaveChat(BuildContext context) async {
  bool leave = false;

  leave = await showModalBottomSheet(
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
      return LeaveChatBottomSheet();
    },
  ).then((value) {
    if (value == null) {
      return false; //if modalBottomSheet is closed dismissible so it will return false to handle error
    }
    return value;
  });
  return leave;
}

class LeaveChatBottomSheet extends StatefulWidget {
  const LeaveChatBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<LeaveChatBottomSheet> createState() => _LeaveChatBottomSheetState();
}

class _LeaveChatBottomSheetState extends State<LeaveChatBottomSheet> {
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
          height: 26.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Text(
                'are you sure you want to leave findmypal?',
                textAlign: TextAlign.center,
                style: getBoldStyle(
                    fontSize: MyFonts.size16,
                    color: MyColors.black,
                    isMontserrat: true),
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                'closing will end any chats, you can always come back and start finding new friends again',
                textAlign: TextAlign.center,
                style: getMediumStyle(
                    fontSize: MyFonts.size14, isMontserrat: true),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 26.h,
        ),
        Center(
          child: CustomButton(
            buttonText: 'keep chatting',
            onPressed: () {
              Navigator.pop(context, false);
            },
            buttonWidth: 318.w,
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(
              'leave session',
              style: getSemiBoldStyle(
                  fontSize: MyFonts.size14,
                  color: MyColors.newPinkColor,
                  isMontserrat: true),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
