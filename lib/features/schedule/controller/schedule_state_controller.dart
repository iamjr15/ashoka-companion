import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/features/schedule/data/apis/schedule_apis.dart';
import 'package:gojek_university_app/features/schedule/data/models/schedule_model.dart';


/// Handle for Schedule State Controller
/// This handle is mainly responsible for interacting with Datasource class.
final scheduleStateController = StateNotifierProvider<ScheduleStateController, bool>((ref) {
  final scheduleAps = ref.watch(scheduleApis);
  return ScheduleStateController(scheduleApiss: scheduleAps);
});

/// Handle for fetching all available schedules.
final getAlLSchedulesController = StreamProvider((ref) {
  final scheduleCtr = ref.watch(scheduleStateController.notifier);
  return scheduleCtr.getAllSchedules();
});


/// Schedule Stae Controller Class, which is extending
/// Riverpod's StateNotifier to saving the state.
class ScheduleStateController extends StateNotifier<bool> {
  ScheduleApis _scheduleApiss;

  ScheduleStateController({required ScheduleApis scheduleApiss})
      : _scheduleApiss = scheduleApiss,
        super(false);

  /// This method is responsible for uploading all dummy schedules.
  Future<void> createScheudule({
  required ScheduleModel scheduleModel
}) async {
    state = true;
    
    final result = await _scheduleApiss.createSchedule(scheduleModel: scheduleModel);

    /// Here its getting Result in the Form of Either Left or Right,
    /// Means Either it has Data or Error.
    /// Utilizing this, we can handle the error and data effectively.
    result.fold((l) {
      state = false;
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint( l.message);
    }, (r) async {
      state = false;
    });
  }
  

  /// This method is responsible for getting all schedules,
  /// Then utilizing riverpod, we are handling it effectively.
  Stream<List<ScheduleModel>> getAllSchedules(){
    return _scheduleApiss.getAllSchedules().map((items){
      List<ScheduleModel> modelList = [];
      items.docs.forEach((item) {
        print(item.data());
        ScheduleModel model = ScheduleModel.fromMap(item.data() as Map<String, dynamic>);
        modelList.add(model);
      });

      return modelList;
    });
  }
}