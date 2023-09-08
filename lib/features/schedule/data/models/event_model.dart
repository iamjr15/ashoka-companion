/// Class for Events in the Schedules.
class EventModel {
  final String eventName;
  final String location;
  final String time;

//<editor-fold desc="Data Methods">
  const EventModel({
    required this.eventName,
    required this.location,
    required this.time,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventModel &&
          runtimeType == other.runtimeType &&
          eventName == other.eventName &&
          location == other.location &&
          time == other.time );

  @override
  int get hashCode =>
      eventName.hashCode ^ location.hashCode ^ time.hashCode ;

  @override
  String toString() {
    return 'EventModel{' +
        ' eventName: $eventName,' +
        ' location: $location,' +
        ' time: $time,' +
        '}';
  }

  EventModel copyWith({
    String? eventName,
    String? location,
    String? time,
  }) {
    return EventModel(
      eventName: eventName ?? this.eventName,
      location: location ?? this.location,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventName': this.eventName,
      'location': this.location,
      'time': this.time,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      eventName: map['eventName'] as String,
      location: map['location'] as String,
      time: map['time'] as String,
    );
  }

//</editor-fold>
}


/// This is the dummy data for Events.
List<EventModel> eventModels = [
  const EventModel(eventName: 'Cohort Introduction', location: 'GJ04-003', time: '11:00 AM'),
  const EventModel(eventName: 'Fresher\'s Lunch', location: 'GJ04-003', time: '11:00 AM'),
  const EventModel(eventName: 'Campus Walk', location: 'GJ04-003', time: '11:00 AM'),
  const EventModel(eventName: 'Keynote Address', location: 'GJ04-003', time: '11:00 AM'),
];
