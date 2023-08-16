import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/thems/styles_manager.dart';

class InstaHandleTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onFieldSubmitted;
  final TextInputType? inputType;
  final bool obscure;
  final IconData? icon;
  final String? Function(String?)? validatorFn;
  final Widget leadingIcon;
  final Widget? tailingIcon;
  final String? leadingIconPath;
  final String? errorText;

  const InstaHandleTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.onFieldSubmitted,
    this.inputType,
    required this.leadingIcon,
    required this.obscure,
    this.validatorFn,
    this.icon, this.tailingIcon, this.leadingIconPath, this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(leadingIconPath);
    return Container(
      constraints: BoxConstraints(
        minHeight: 47.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white ,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextFormField(
        validator: validatorFn,
        obscureText: obscure,
        controller: controller,
        keyboardType: inputType,
        style: getRegularStyle(fontSize: MyFonts.size12,color:MyColors.black ),
        decoration: InputDecoration(
          errorText: errorText ?? null,
          prefixIcon: leadingIcon,
          errorStyle:getRegularStyle(fontSize: MyFonts.size10,color:MyColors.errorColor) ,
          suffixIcon: tailingIcon,
          hintText: hintText,
          hintStyle: getRegularStyle(fontSize: MyFonts.size12,color:MyColors.black.withOpacity(0.7) ),
          enabledBorder: const OutlineInputBorder(
            borderSide:
            BorderSide(color:MyColors.black, width: 2.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: MyColors.black, width: 2.0),
          ),
          border: const OutlineInputBorder(),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.black, width: 2.0),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: MyColors.black,
                width: 2.0),
          ),
        ),
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
      ),
    );
  }
}
