import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/thems/styles_manager.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onFieldSubmitted;
  final TextInputType? inputType;
  final bool obscure;
  final IconData? icon;
  final String? Function(String?)? validatorFn;
  final Widget? leadingIcon;
  final Widget? tailingIcon;
  final String? leadingIconPath;
  final double? texfieldHeight;
  final String label;
  final bool showLabel;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.onFieldSubmitted,
    this.inputType,
    this.leadingIcon,
    required this.obscure,
    this.validatorFn,
    this.icon, this.tailingIcon, this.leadingIconPath, this.texfieldHeight, required this.label,  this.showLabel=true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(showLabel)...[
          Text(label,style: getSemiBoldStyle(isMontserrat: true,fontSize: MyFonts.size18,color: MyColors.newTextBlackSecondaryColor),),
        ],
        Container(
          constraints: texfieldHeight!= null ? BoxConstraints(
            minHeight:texfieldHeight!
          ): BoxConstraints(
            minHeight:62.h
    ),
          margin: EdgeInsets.only(bottom: 5.h, top: 10.h),
          decoration: BoxDecoration(
            color: Colors.white ,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: TextFormField(
            validator: validatorFn,
            obscureText: obscure,
            controller: controller,
            keyboardType: inputType,
            style: getMediumStyle(fontSize: MyFonts.size16,color:MyColors.black ,isMontserrat: true),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              // prefixIcon: leadingIconPath !=null?
              // Padding(
              //   padding: EdgeInsets.all(13.0.h),
              //   child: Image.asset(
              //     leadingIconPath!,
              //     width: 15.w,
              //     height: 15.h,
              //   ),
              // ):null,
              errorStyle:getRegularStyle(fontSize: MyFonts.size10,color:MyColors.errorColor) ,
              suffixIcon: tailingIcon,
              hintText: hintText,
              hintStyle: getMediumStyle(fontSize: MyFonts.size16,color:MyColors.newTextBlackSecondaryColor,isMontserrat: true),
              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide:
                BorderSide(color:MyColors.newTextFieldColor, width: 1.44),
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide:
                BorderSide(color:MyColors.newTextFieldColor, width: 1.44),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide:
                BorderSide(color:MyColors.newTextFieldColor, width: 1.44),
              ),
              focusedErrorBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide:
                BorderSide(color:MyColors.newTextFieldColor, width: 1.44),
              ),
              errorBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide:
                BorderSide(color:MyColors.newTextFieldColor, width: 1.44),
              ),
            ),
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
