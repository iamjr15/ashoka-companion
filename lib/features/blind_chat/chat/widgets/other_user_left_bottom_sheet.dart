import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gojek_university_app/commons/common_widgets/common_outline_border_button.dart';
import 'package:gojek_university_app/commons/common_widgets/custom_button.dart';
import 'package:gojek_university_app/features/blind_chat/controller/blind_chat_controller.dart';
import 'package:gojek_university_app/features/navigation_menu/controller/navigation_controller.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/thems/styles_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';

Future<bool> otherUserLeft(BuildContext context, String otherName) async {
  bool chatToElse = false;

  chatToElse = await showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    useRootNavigator: true,
    isScrollControlled: true,
    isDismissible: false,
    barrierColor: Colors.black45.withOpacity(0.8),
    elevation: 10,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      topLeft: Radius.circular(20),
    )),
    builder: (context) {
      return OtherUserLeftBottomSheet(
        otherName: otherName,
      );
    },
  ).then((value) {
    if (value == null) {
      return false; //if modalBottomSheet is closed dismissible so it will return false to handle error
    }
    return true;
  });
  return chatToElse;
}

class OtherUserLeftBottomSheet extends StatefulWidget {
  const OtherUserLeftBottomSheet({
    Key? key,
    required this.otherName,
  }) : super(key: key);

  final String otherName;

  @override
  State<OtherUserLeftBottomSheet> createState() =>
      _OtherUserLeftBottomSheetState();
}

class _OtherUserLeftBottomSheetState extends State<OtherUserLeftBottomSheet> {
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
                '${widget.otherName} has left the chat',
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
                'start a new chat to keep chatting with other people',
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
            buttonText: 'chat to someone else',
            onPressed: () {
              Navigator.pop(context, true);
            },
            buttonWidth: 318.w,
          ),
        ),
        SizedBox(
          height: 14.h,
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final navCtr = ref.watch(navigationController);
            return Center(
              child: TextButton(
                onPressed: () async {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.mainMenuScreen, (route) => false);
                  navCtr.setIndex(2);
                },
                child: Text(
                  'leave session',
                  style: getSemiBoldStyle(
                      fontSize: MyFonts.size14,
                      color: MyColors.newPinkColor,
                      isMontserrat: true),
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
