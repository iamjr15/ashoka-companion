/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants/font_manager.dart';
import '../../../utils/thems/my_colors.dart';
import '../../../utils/thems/styles_manager.dart';
import '../gestures/tap.dart';

class DateWidget extends StatefulWidget {
  final double? width;
  final DateTime date;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color? selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;

  DateWidget({
    required this.date,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  @override
  Widget build(BuildContext context) {
    String abbreviatedDay = DateFormat.E(widget.locale).format(widget.date);
    // Create a map to map the abbreviated days to the desired format
    DateTime currentDate = DateTime.now();

    Map<String, String> dayMap = {
      'Mon': 'mon',
      'Tue': 'tue',
      'Wed': 'wed',
      'Thu': 'thu',
      'Fri': 'fri',
      'Sat': 'sat',
      'Sun': 'sun',
    };
    return widget.selectionColor != null  ?
    InkWell(
      borderRadius: BorderRadius.circular(30),
      splashColor: Colors.transparent,
      focusColor:  Colors.transparent,
      highlightColor:  Colors.transparent,
      child: Container(
        width: 48.w,
        height: 105.h,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 13.h, bottom: 11.h),
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.r),
          color: MyColors.newLightYellowColor
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(dayMap[abbreviatedDay]!, // WeekDay
                style: getBoldStyle(
                      fontSize: MyFonts.size16,
                      color: MyColors.newYellowColor
                    )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.date.day.toString(), // Date
                    style:
                    getSemiBoldStyle(
                        fontSize: MyFonts.size31,
                        color: MyColors.newYellowColor
                    )
              ),
              Container(
                width: 5.w,
                height: 5.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.newYellowColor
                ),
              )
            ],
          )
          ],
        ),
      ),
      onTap: () {
        // Check if onDateSelected is not null
        if (widget.onDateSelected != null) {
          // Call the onDateSelected Function
          widget.onDateSelected!(this.widget.date);
        }
      },
    ):
    InkWell(
      borderRadius: BorderRadius.circular(30),
      splashColor: Colors.transparent,
      focusColor:  Colors.transparent,
      highlightColor:  Colors.transparent,
      child: Container(
        width: 34.w,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        constraints: BoxConstraints(
          maxHeight: 49.h,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 15.h ) ,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.r),
            color: MyColors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(dayMap[abbreviatedDay]!, // WeekDay
                style:
                getMediumStyle(
                    fontSize: MyFonts.size16,
                    color: MyColors.newTextBlackSecondaryColor
                )),
            Text(
              widget.date.day.toString(),
              style: getSemiBoldStyle(
                  fontSize: MyFonts.size31,
                  color: MyColors.black
              ),
            )

          ],
        ),
      ),
      onTap: () {
        // Check if onDateSelected is not null
        if (widget.onDateSelected != null) {
          // Call the onDateSelected Function
          widget.onDateSelected!(this.widget.date);
        }
      },
    );
  }
}
