
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_colors.dart';


ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: MyColors.themeColor,
    scaffoldBackgroundColor: MyColors.white,
    appBarTheme: appBarTheme,
    iconTheme: const IconThemeData(color: MyColors.secondaryTextColor),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: MyColors.secondaryTextColor),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => MyColors.themeColor),
      overlayColor:  MaterialStateColor.resolveWith((states) => MyColors.textColor),
    ),

    colorScheme: const ColorScheme.light(
      primary: MyColors.themeColor,
      secondary: MyColors.textColor,
      tertiary:  MyColors.secondaryTextColor,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 1.h,
      backgroundColor: Colors.white,
      selectedItemColor: MyColors.themeColor,
      unselectedItemColor: MyColors.textColor,
      selectedIconTheme: const IconThemeData(color: MyColors.themeColor),
      showUnselectedLabels: true,
    ),
  );
}
//
// ThemeData darkThemeData(BuildContext context) {
//   // Bydefault flutter provie us light and dark theme
//   // we just modify it as our need
//   return ThemeData.dark().copyWith(
//     primaryColor: Pallete.kPrimaryColor,
//     scaffoldBackgroundColor: Pallete.kContentColorLightTheme,
//     appBarTheme: appBarTheme,
//     iconTheme: const IconThemeData(color: Pallete.kContentColorDarkTheme),
//     textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
//         .apply(secondaryTextColor: Pallete.kContentColorDarkTheme),
//     colorScheme: const ColorScheme.dark().copyWith(
//       primary: Pallete.kPrimaryColor,
//       onPrimary: Pallete.kWhiteColor,
//       onSecondary: Pallete.kOnSecondaryColor,
//       secondary: Pallete.kSecondaryColor,
//       error: Pallete.kErrorColor,
//     ),
//     bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       backgroundColor: Pallete.kContentColorLightTheme,
//       selectedItemColor: Colors.white70,
//       unselectedItemColor: Pallete.kContentColorDarkTheme.withOpacity(0.32),
//       selectedIconTheme: const IconThemeData(color: Pallete.kPrimaryColor),
//       showUnselectedLabels: true,
//     ),
//   );
// }

const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0, color: MyColors.themeColor);
