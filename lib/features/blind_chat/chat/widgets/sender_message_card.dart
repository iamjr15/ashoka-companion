
import 'package:flutter/material.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/commons/enums/message_enum.dart';
import 'package:gojek_university_app/utils/thems/my_colors.dart';
import 'package:gojek_university_app/utils/thems/styles_manager.dart';
import '../../../../utils/constants/font_manager.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
  }) : super(key: key);
  final String message;
  final String date;
  final MessageEnum type;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.r),
            topLeft: Radius.circular(15.r),
            bottomRight: Radius.circular(15.r),
          )),
          color: MyColors.senderMessageCardColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
            child: Text(message,
                style: getMediumStyle(
                    fontSize: MyFonts.size13, color: MyColors.black,isMontserrat: true)),
          ),
        ),
      ),
    );
  }
}
