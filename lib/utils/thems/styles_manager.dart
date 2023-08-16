import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/font_manager.dart';
import 'my_colors.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color,
) {
  return GoogleFonts.poppins(
    color: color,
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
  );
}

TextStyle _getMontserratTextStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color,
    ) {
  return GoogleFonts.montserrat(
    color: color,
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
  );
}

// regular style
TextStyle getRegularStyle({
  double fontSize = 16,
  Color color = MyColors.textColor,
  bool isMontserrat=false,
}) {
  if(isMontserrat){
    return _getMontserratTextStyle(fontSize.sp, FontWeightManager.regular, color);
  }else{
    return _getTextStyle(fontSize.sp, FontWeightManager.regular, color);
  }
}

// medium style
TextStyle getMediumStyle({
  double fontSize = 16,
  Color color = MyColors.textColor,
  bool isMontserrat=false,
}) {
  if(isMontserrat){
    return _getMontserratTextStyle(fontSize.sp, FontWeightManager.medium, color);
  }else{
    return _getTextStyle(fontSize.sp, FontWeightManager.medium, color);
  }
}


// medium style
TextStyle getLightStyle({
  double fontSize = 14,
  Color color = MyColors.textColor,
  bool isMontserrat=false,
}) {
  if(isMontserrat){
    return _getMontserratTextStyle(fontSize.sp, FontWeightManager.light, color);
  }else{
    return _getTextStyle(fontSize.sp, FontWeightManager.light, color);
  }
}

// bold style
TextStyle getBoldStyle({
  double fontSize = 14,
  Color color = MyColors.textColor,
  bool isMontserrat=false,
}) {
  if(isMontserrat){
    return _getMontserratTextStyle(fontSize.sp, FontWeightManager.bold, color);
  }else{
    return _getTextStyle(fontSize.sp, FontWeightManager.bold, color);
  }
}


// semibold style
TextStyle getSemiBoldStyle({
  double fontSize = 14,
  Color color = MyColors.textColor,
  bool isMontserrat=false,
}) {
  if(isMontserrat){
    return _getMontserratTextStyle(fontSize.sp, FontWeightManager.semiBold, color);
  }else{
    return _getTextStyle(fontSize.sp, FontWeightManager.semiBold, color);
  }
}


// bold style
TextStyle getExtraBoldStyle({
  double fontSize = 14,
  Color color = MyColors.textColor,
  bool isMontserrat=false,
}) {
  if(isMontserrat){
    return _getMontserratTextStyle(fontSize.sp, FontWeightManager.extrBold, color);
  }else{
    return _getTextStyle(fontSize.sp, FontWeightManager.extrBold, color);
  }
}



TextStyle getBoldSigInHeadingStyle({
  double fontSize = 14,
  Color color = MyColors.textColor,
}) {
  return GoogleFonts.montserrat(
      color: color,
      fontSize: fontSize.spMin,
      fontWeight: FontWeightManager.extrBold,
      height: 1.2);
}