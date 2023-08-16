import 'package:flutter/material.dart';

String datetimeToTimeString(DateTime dateTime) {
  String period = 'am';
  int hour = dateTime.hour;
  if (hour >= 12) {
    period = 'pm';
    if (hour > 12) {
      hour -= 12;
    }
  }
  String minute = dateTime.minute.toString().padLeft(2, '0');
  return '$hour.$minute $period';
}

DateTime timeOfDayToDateTime(TimeOfDay timeOfDay) {
  TimeOfDay currentTime = timeOfDay;

  DateTime currentDateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    currentTime.hour,
    currentTime.minute,
  );

  return currentDateTime;
}

TimeOfDay dateTimeToTimeOfDay(DateTime dateTime) {
  DateTime currentDateTime = dateTime;
  // Convert DateTime to TimeOfDay
  TimeOfDay currentTime = TimeOfDay.fromDateTime(currentDateTime);
  return currentTime;
}

DateTime stringToDateTime(String timeString) {
  // Split the time string into hours, minutes, and am/pm indicator
  List<String> parts = timeString.split(' ');

  // Extract the hour and minute values
  List<String> timeParts = parts[0].split('.');
  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1]);

  // Determine if it's am or pm
  bool isAm = parts[1].toLowerCase() == 'am';

  // Adjust the hour for pm time (12-hour format)
  if (!isAm && hour != 12) {
    hour += 12;
  }

  // Get the current date
  DateTime now = DateTime.now();

  // Create the DateTime object with today's date and the specified time
  DateTime dateTime = DateTime(now.year, now.month, now.day, hour, minute);

  return dateTime;
}
