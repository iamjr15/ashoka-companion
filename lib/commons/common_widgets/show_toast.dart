import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:gojek_university_app/utils/thems/styles_manager.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';



showSnackBar(BuildContext context, String content){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content,style: getRegularStyle(fontSize: 12.spMin,color: Colors.white),),
      )
  );
}
void showToast({required String msg, Color? textColor, Color? backgroundColor ,bool long=false}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength:long?Toast.LENGTH_LONG: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor?? Colors.white,
    textColor: textColor ?? Colors.black,
    fontSize: 12.spMin,
  );
}
showAwesomeSnackBar({required BuildContext context, required String title, required String msg, required ContentType type}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          color: MyColors.newPinkColor,
          title: title,
          message:msg,
          contentType: type,
        ),
      )
  );
}