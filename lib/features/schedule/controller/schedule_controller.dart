import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/features/schedule/data/apis/schedule_apis.dart';
import 'package:gojek_university_app/features/schedule/data/models/event_model.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/firebase_constants.dart';
import '../data/models/schedule_model.dart';


/// Handle for Schedule Notifier Controller.
final scheduleController = ChangeNotifierProvider((ref) => ScheduleController());

class ScheduleController extends ChangeNotifier {

  // This is the dummy data for schedules,
  // will use it to upload on Firebase FireStore.
  final List<ScheduleModel> scheduleModels = [
    ScheduleModel(scheduleId: '14', dayDate: DateTime(2023, 8, 19), dayEvents: eventModels),
    ScheduleModel(scheduleId: '15', dayDate: DateTime(2023, 8, 20), dayEvents: eventModels),
    ScheduleModel(scheduleId: '16', dayDate: DateTime(2023, 8, 21), dayEvents: eventModels),
    ScheduleModel(scheduleId: '17', dayDate: DateTime(2023, 8, 22), dayEvents: eventModels),
    ScheduleModel(scheduleId: '18', dayDate: DateTime(2023, 8, 23), dayEvents: eventModels),
    ScheduleModel(scheduleId: '19', dayDate: DateTime(2023, 8, 24), dayEvents: eventModels),
    ScheduleModel(scheduleId: '20', dayDate: DateTime(2023, 8, 25), dayEvents: eventModels),
    ScheduleModel(scheduleId: '21', dayDate: DateTime(2023, 8, 26), dayEvents: eventModels),
    ScheduleModel(scheduleId: '22', dayDate: DateTime(2023, 8, 27), dayEvents: eventModels),
    ScheduleModel(scheduleId: '23', dayDate: DateTime(2023, 8, 28), dayEvents: eventModels),
    ScheduleModel(scheduleId: '24', dayDate: DateTime(2023, 8, 29), dayEvents: eventModels),
  ];


  /// Getter and Setters for Schedules,
  /// which we are fetching from Firebase Firestore.
  List<ScheduleModel> _schedules = [];
  List<ScheduleModel> get schedules => _schedules;
  Future<void> fetchSchedules() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection(FirebaseConstants.studentScheduleCollection).get();
      _schedules = snapshot.docs.map((doc) => ScheduleModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
      setScheduleModelForDay(models: _schedules);
      notifyListeners();
    } catch (error, st) {
      debugPrintStack(stackTrace: st);
      debugPrint(error.toString());
    }
  }

  /// On Schedule Screen, we are showing the day name as well.
  String _todayName = '';
  String get todayName => _todayName;
  setTodayName(String val){
    _todayName = val;

  }


  /// We are first setting this active date according
  /// to the schedule and then showing it on the schedule screen.
  DateTime _activeDate = DateTime.now();
  DateTime get activeDate => _activeDate;
  setActiveDate({required DateTime date, required List<ScheduleModel> models}){
    _activeDate = date;
    /// Here first we check if the model is related to
    /// the selected date, based on that we are storing that model
    /// to the todays model variable.
    for (ScheduleModel model in models) {
      if(model.dayDate.day == date.day && model.dayDate.year == date.year && model.dayDate.month == date.month){
        settodaySchedule(model);
      }
    }
    notifyListeners();
  }


  /// This is the schedule for today, we are setting it
  /// by compairing the models date with the actual date comming from
  /// calendar, based on that we are showing selected day model.
  ScheduleModel? _todaysSchedule;
  ScheduleModel? get todaysSchedule => _todaysSchedule;
  settodaySchedule(ScheduleModel? model){
    _todaysSchedule = model;
    notifyListeners();
  }

  /// We are using this method to get the schedule model for the
  /// specific selected date.
  setScheduleModelForDay({required List<ScheduleModel> models}){
    settodaySchedule(null);
    for (ScheduleModel model in models) {
      if(model.dayDate.day == activeDate.day && model.dayDate.month == activeDate.month &&model.dayDate.year == activeDate.year){
        settodaySchedule(model);
      }
    }
  }

  /// We are using this model to get the day name based on the date we provide
  /// and it return the Name of the provided date.
  String getTodayDayNameAndDate(DateTime now) {
    String dayName = '';
    switch (now.weekday) {
      case 1:
        dayName = 'monday';
        break;
      case 2:
        dayName = 'tuesday';
        break;
      case 3:
        dayName = 'wednesday';
        break;
      case 4:
        dayName = 'thursday';
        break;
      case 5:
        dayName = 'friday';
        break;
      case 6:
        dayName = 'saturday';
        break;
      case 7:
        dayName = 'sunday';
        break;
    }
    // String formattedDate = getFormattedDate(now);
    return  dayName ;
  }
}
