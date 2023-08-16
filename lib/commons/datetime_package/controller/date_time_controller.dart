import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateTimeController = ChangeNotifierProvider((ref) => DateTimeController());

class DateTimeController extends ChangeNotifier{



  DateTime _dateTime = DateTime.now();
  DateTime dateTime = DateTime.now();
  DateTime get getDatetime =>  _dateTime;
  setIndex(DateTime val){
    _dateTime = val;
    print(val);
    notifyListeners();
  }
}