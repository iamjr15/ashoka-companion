import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gojek_university_app/commons/enums/message_enum.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/thems/my_colors.dart';
import 'package:gojek_university_app/utils/thems/styles_manager.dart';


class MyMessageCard extends StatelessWidget {
  final String message;

  const MyMessageCard(
      {Key? key,
      required this.message,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
          minWidth: 110,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24.r),
                        topLeft: Radius.circular(24.r),
                        bottomLeft: Radius.circular(24.r))),
                color: MyColors.chatBotMyTextColor,

                child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    child: Text(message,
                        style: getMediumStyle(
                            fontSize: MyFonts.size13, color: MyColors.white,isMontserrat: true))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
