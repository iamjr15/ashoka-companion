import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/thems/styles_manager.dart';

class AddInterestsWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onFieldSubmitted;
  final VoidCallback onArrowTapped;
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

  const AddInterestsWidget({
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
    required this.onArrowTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
              minHeight: 70.h
          ),
          decoration: BoxDecoration(
            color: MyColors.newInterestsTextFieldColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: TextFormField(
            validator: validatorFn,
            obscureText: obscure,
            controller: controller,
            keyboardType: inputType,
            style: getMediumStyle(fontSize: MyFonts.size18,color:MyColors.black ,isMontserrat: true),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20.w,right: 20.w,bottom: 22.h, top: 26.h,),
              errorStyle:getRegularStyle(fontSize: MyFonts.size10,color:MyColors.errorColor) ,
              suffixIcon: GestureDetector(
                onTap: onArrowTapped,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  child: Image.asset(
                    AppAssets.arrowForwardNew,
                    width: 16.w,
                    height: 21.h,
                    color: MyColors.newPinkColor,
                  ),
                ),
              ),
              hintText: hintText,
              hintStyle: getMediumStyle(fontSize: MyFonts.size18,color:MyColors.newTextBlackSecondaryColor,isMontserrat: true),
              enabledBorder:  InputBorder.none,
              focusedBorder:  InputBorder.none,
              border: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              errorBorder:  InputBorder.none,
            ),
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
