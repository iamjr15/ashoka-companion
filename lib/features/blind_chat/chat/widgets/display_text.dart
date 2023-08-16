import 'package:flutter/material.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/commons/enums/message_enum.dart';
import 'package:gojek_university_app/utils/thems/styles_manager.dart';

class DisplayText extends StatelessWidget {
  final String message;
  final MessageEnum type;

  const DisplayText({Key? key, required this.message, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(message,
        style: getMediumStyle(fontSize: 12.spMin, color: MyColors.white));
  }
}
