import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:timeago/timeago.dart' as timeago;


// Random Functions to add here
getTimeAgo(DateTime dt){
  return timeago.format(dt, allowFromNow: true, locale: 'en_short');
}




Widget spacer({double height = 16}) {
  return SizedBox(
    height: height,
  );
}

DateTime getDateTimeFromUnix(int dt) =>
    DateTime.fromMillisecondsSinceEpoch(dt * 1000);

String getTimeInHour(int dt) {
  final curDt = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
  final hour = DateFormat('hh a').format(curDt);
  return hour;
}

String getTimeInHHMM(int dt) {
  final curDt = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
  final hour = DateFormat('hh:mm a').format(curDt);
  return hour;
}

String getDayFromEpoch(int dt) {
  final curDt = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
  final day = DateFormat('EEEE').format(curDt);
  return day;
}



class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key, this.message = "Something went wrong !"})
      : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: getMediumStyle(fontSize: 12.spMin),
      ),
    );
  }
}

class NoRecordFound extends StatelessWidget {
  const NoRecordFound({Key? key, this.message = "No Records"})
      : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style:  getMediumStyle(fontSize: 12.spMin),
      ),
    );
  }
}
