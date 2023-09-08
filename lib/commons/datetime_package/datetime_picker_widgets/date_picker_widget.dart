import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants/font_manager.dart';
import '../../../utils/thems/my_colors.dart';
import '../../../utils/thems/styles_manager.dart';
import '../controller/date_time_controller.dart';
import '../datetime_provider.dart';
import '../extra/color.dart';
import '../extra/style.dart';
import '../gestures/tap.dart';
import 'date_widget.dart';

class DatePicker extends ConsumerStatefulWidget {
  /// Start Date in case user wants to show past dates
  /// If not provided calendar will start from the initialSelectedDate
  final DateTime startDate;
  final bool? isSchedule;

  /// Width of the selector
  final double width;

  /// Height of the selector
  final double height;

  /// DatePicker Controller
  final DatePickerController? controller;

  /// Text color for the selected Date
  final Color selectedTextColor;

  /// Background color for the selector
  final Color selectionColor;

  /// Text Color for the deactivated dates
  final Color deactivatedColor;

  /// TextStyle for Month Value
  final TextStyle monthTextStyle;

  /// TextStyle for day Value
  final TextStyle dayTextStyle;

  /// TextStyle for the date Value
  final TextStyle dateTextStyle;

  /// Current Selected Date
  final DateTime? /*?*/ initialSelectedDate;

  /// Contains the list of inactive dates.
  /// All the dates defined in this List will be deactivated
  final List<DateTime>? inactiveDates;

  /// Contains the list of active dates.
  /// Only the dates in this list will be activated.
  final List<DateTime>? activeDates;

  /// Callback function for when a different date is selected
  final DateChangeListener? onDateChange;

  /// Max limit up to which the dates are shown.
  /// Days are counted from the startDate
  final int daysCount;

  /// Locale for the calendar default: en_us
  final String locale;

  DatePicker(
    this.startDate, {
    Key? key,
    this.width = 60,
    this.height = 80,
    this.controller,
    this.monthTextStyle = defaultMonthTextStyle,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectedTextColor = Colors.white,
    this.selectionColor = AppColors.defaultSelectionColor,
    this.deactivatedColor = AppColors.defaultDeactivatedColor,
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.daysCount = 500,
    this.onDateChange,
    this.locale = "en_US", this.isSchedule = false,
  }) : assert(
            activeDates == null || inactiveDates == null,
            "Can't "
            "provide both activated and deactivated dates List at the same time.");

  @override
  ConsumerState createState() => new _DatePickerState();
}

class _DatePickerState extends ConsumerState<DatePicker> {

  DateTime? _currentDate;

  ScrollController _controller = ScrollController();

  late final TextStyle selectedDateStyle;
  late final TextStyle selectedMonthStyle;
  late final TextStyle selectedDayStyle;

  late final TextStyle deactivatedDateStyle;
  late final TextStyle deactivatedMonthStyle;
  late final TextStyle deactivatedDayStyle;

  @override
  void initState() {
    // Init the calendar locale
    initializeDateFormatting(widget.locale, null);
    // Set initial Values
    _currentDate = widget.initialSelectedDate;

    if (widget.controller != null) {
      widget.controller!.setDatePickerState(this);
    }

    this.selectedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.selectedTextColor);
    this.selectedMonthStyle =
        widget.monthTextStyle.copyWith(color: widget.selectedTextColor);
    this.selectedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.selectedTextColor);

    this.deactivatedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.deactivatedColor);
    this.deactivatedMonthStyle =
        widget.monthTextStyle.copyWith(color: widget.deactivatedColor);
    this.deactivatedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.deactivatedColor);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        if(widget.isSchedule!){

          final scheduleDateTimeProvider = ref.watch(datetimeProvider);
          final scheduleCtr = ref.watch(dateTimeController);
          ScrollController _controller = ScrollController();
          return SizedBox(
            height: 105.h,
            width: MediaQuery.of(context).size.width - 70.w,
            child: ListView.builder(
              itemCount: widget.daysCount,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              controller: _controller,
              itemBuilder: (context, index) {
                DateTime date;
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  scheduleDateTimeProvider.setScheduleIndex(index - 5);
                });
                DateTime _date =
                scheduleCtr.dateTime.add(Duration(days: index));
                date = DateTime(_date.year, _date.month, _date.day);

                bool isDeactivated = false;

                if (widget.inactiveDates != null) {
                  for (DateTime inactiveDate in widget.inactiveDates!) {
                    if (_compareDate(date, inactiveDate)) {
                      isDeactivated = true;
                      break;
                    }
                  }
                }

                if (widget.activeDates != null) {
                  isDeactivated = true;
                  for (DateTime activateDate in widget.activeDates!) {
                    if (_compareDate(date, activateDate)) {
                      isDeactivated = false;
                      break;
                    }
                  }
                }

                bool isSelected = _currentDate != null
                    ? _compareDate(date, _currentDate!)
                    : false;

                return DateWidget(
                  date: date,
                  monthTextStyle: isDeactivated
                      ? deactivatedMonthStyle
                      : isSelected
                      ? selectedMonthStyle
                      : widget.monthTextStyle,
                  dateTextStyle: isDeactivated
                      ? deactivatedDateStyle
                      : isSelected
                      ? selectedDateStyle
                      : widget.dateTextStyle,
                  dayTextStyle: isDeactivated
                      ? deactivatedDayStyle
                      : isSelected
                      ? selectedDayStyle
                      : widget.dayTextStyle,
                  width: widget.width,
                  locale: widget.locale,
                  selectionColor: isSelected ? widget.selectionColor : null,
                  onDateSelected: (selectedDate) {
                    if (isDeactivated) return;
                    if (widget.onDateChange != null) {
                      widget.onDateChange!(selectedDate);
                    }
                    setState(() {
                      _currentDate = selectedDate;
                    });
                  },
                );
              },
            ),
          );
        } else{

          final provider = ref.watch(datetimeProvider);
          DateTime _date = widget.startDate.add(Duration(days: provider.index));
          ScrollController _controller = ScrollController();

          String getFormattedDate() {
            // print(DateFormat('MMMM yyyy').format(_date));
            return DateFormat('MMMM yyyy').format(_date);
          }

          return SizedBox(
            height: 105.h,
            width: MediaQuery.of(context).size.width - 70.w,
            child: ListView.builder(
              itemCount: widget.daysCount,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              controller: _controller,
              itemBuilder: (context, index) {
                DateTime date;
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  provider.setIndex(index - 5);
                });
                DateTime _date =
                widget.startDate.add(Duration(days: index));
                date = DateTime(_date.year, _date.month, _date.day);

                bool isDeactivated = false;

                if (widget.inactiveDates != null) {
                  for (DateTime inactiveDate in widget.inactiveDates!) {
                    if (_compareDate(date, inactiveDate)) {
                      isDeactivated = true;
                      break;
                    }
                  }
                }

                if (widget.activeDates != null) {
                  isDeactivated = true;
                  for (DateTime activateDate in widget.activeDates!) {
                    if (_compareDate(date, activateDate)) {
                      isDeactivated = false;
                      break;
                    }
                  }
                }

                bool isSelected = _currentDate != null
                    ? _compareDate(date, _currentDate!)
                    : false;

                return DateWidget(
                  date: date,
                  monthTextStyle: isDeactivated
                      ? deactivatedMonthStyle
                      : isSelected
                      ? selectedMonthStyle
                      : widget.monthTextStyle,
                  dateTextStyle: isDeactivated
                      ? deactivatedDateStyle
                      : isSelected
                      ? selectedDateStyle
                      : widget.dateTextStyle,
                  dayTextStyle: isDeactivated
                      ? deactivatedDayStyle
                      : isSelected
                      ? selectedDayStyle
                      : widget.dayTextStyle,
                  width: widget.width,
                  locale: widget.locale,
                  selectionColor: isSelected ? widget.selectionColor : null,
                  onDateSelected: (selectedDate) {
                    if (isDeactivated) return;
                    if (widget.onDateChange != null) {
                      widget.onDateChange!(selectedDate);
                    }
                    setState(() {
                      _currentDate = selectedDate;
                    });
                  },
                );
              },
            ),
          );
        }

      },
    );
  }

  /// Helper function to compare two dates
  /// Returns True if both dates are the same
  bool _compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }
}

class DatePickerController {
  _DatePickerState? _datePickerState;

  void setDatePickerState(_DatePickerState state) {
    _datePickerState = state;
  }

  void jumpToSelection() {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // jump to the current Date
    _datePickerState!._controller
        .jumpTo(_calculateDateOffset(_datePickerState!._currentDate!));
  }

  /// This function will animate the Timeline to the currently selected Date
  void animateToSelection(
      {duration = const Duration(milliseconds: 500), curve = Curves.easeIn}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // animate to the current date
    _datePickerState!._controller.animateTo(
        _calculateDateOffset(_datePickerState!._currentDate!),
        duration: duration,
        curve: curve);
  }

  /// This function will animate to any date that is passed as an argument
  /// In case a date is out of range nothing will happen
  void animateToDate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.easeIn}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);
  }

  /// This function will animate to any date that is passed as an argument
  /// this will also set that date as the current selected date
  void setDateAndAnimate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.easeIn}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);

    if (date.compareTo(_datePickerState!.widget.startDate) >= 0 &&
        date.compareTo(_datePickerState!.widget.startDate
                .add(Duration(days: _datePickerState!.widget.daysCount))) <=
            0) {
      // date is in the range
      _datePickerState!._currentDate = date;
    }
  }

  /// Calculate the number of pixels that needs to be scrolled to go to the
  /// date provided in the argument
  double _calculateDateOffset(DateTime date) {
    final startDate = new DateTime(
        _datePickerState!.widget.startDate.year,
        _datePickerState!.widget.startDate.month,
        _datePickerState!.widget.startDate.day);

    int offset = date.difference(startDate).inDays;
    return (offset * _datePickerState!.widget.width) + (offset * 6);
  }
}

// void goToNextMonth() {
//   int currentMonth = _date.month;
//   int currentYear = _date.year;
//
//   int nextMonth = currentMonth + 1;
//   int nextYear = currentYear;
//
//   if (nextMonth > 12) {
//     nextMonth = 1;
//     nextYear++;
//   }
//
//   DateTime nextDate = DateTime(nextYear, nextMonth, _date.day);
//   int nextIndex = _calculateIndex(nextDate);
//
//   _date = nextDate;
//   ref.read(datetimeProvider.notifier).setIndex(nextIndex);
//
//   // Scroll to the updated index
//   _controller.animateTo(
//     nextIndex * widget.width, // Assuming width is the item width in the ListView
//     duration: Duration(milliseconds: 300),
//     curve: Curves.easeInOut,
//   );
// }
//
// void goToPreviousMonth() {
//   int currentMonth = _date.month;
//   int currentYear = _date.year;
//
//   int previousMonth = currentMonth - 1;
//   int previousYear = currentYear;
//
//   if (previousMonth < 1) {
//     previousMonth = 12;
//     previousYear--;
//   }
//
//   DateTime previousDate = DateTime(previousYear, previousMonth, _date.day);
//   int previousIndex = _calculateIndex(previousDate);
//
//   _date = previousDate;
//   ref.read(datetimeProvider.notifier).setIndex(previousIndex);
//
//   // Scroll to the updated index
//   _controller.animateTo(
//     previousIndex * widget.width, // Assuming width is the item width in the ListView
//     duration: Duration(milliseconds: 300),
//     curve: Curves.easeInOut,
//   );
// }
