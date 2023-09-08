import 'package:gojek_university_app/features/schedule/data/models/event_model.dart';

/// Schedule Model for handling schedules data.

class ScheduleModel{
  final DateTime dayDate;
  final String scheduleId;
  final List<EventModel> dayEvents;

//<editor-fold desc="Data Methods">
  const ScheduleModel({
    required this.dayDate,
    required this.scheduleId,
    required this.dayEvents,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleModel &&
          runtimeType == other.runtimeType &&
          dayDate == other.dayDate &&
          scheduleId == other.scheduleId &&
          dayEvents == other.dayEvents);

  @override
  int get hashCode =>
      dayDate.hashCode  ^ dayEvents.hashCode ^ scheduleId.hashCode;

  @override
  String toString() {
    return 'ScheduleModel{' +
        ' dayDate: $dayDate,' +
        ' scheduleId: $scheduleId,' +
        ' dayEvents: $dayEvents,' +
        '}';
  }

  ScheduleModel copyWith({
    String? scheduleId,
    DateTime? dayDate,
    List<EventModel>? dayEvents,
  }) {
    return ScheduleModel(
      dayDate: dayDate ?? this.dayDate,
      scheduleId: scheduleId ?? this.scheduleId,
      dayEvents: dayEvents ?? this.dayEvents,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dayDate': this.dayDate.millisecondsSinceEpoch,
      'scheduleId': this.scheduleId,
      'dayEvents': this.dayEvents.map((e) => e.toMap()).toList(),
    };
  }

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
      scheduleId:  map['scheduleId'],
      dayDate:  DateTime.fromMillisecondsSinceEpoch(map['dayDate']),
      dayEvents: (map['dayEvents'] as List<dynamic>)
          .map((e) => EventModel.fromMap(e))
          .toList(),
    );
  }

//</editor-fold>
}