import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:gojek_university_app/features/schedule/data/models/schedule_model.dart';

import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_providers/global_providers.dart';
import '../../../../core/constants/firebase_constants.dart';


/// This is the handle of Schedule Api, we will use it in controller to access methods.
final scheduleApis = Provider<ScheduleApis>((ref) {
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return ScheduleApis(firestore: firestoreProvider);
});


/// This is the Abstract class for the Schedule Apis, just to keep the data safe.
abstract class IScheduleApis {

  /// Using this method to create schedules on Firebase FireStore.
  FutureEitherVoid createSchedule({required ScheduleModel scheduleModel,});
  /// Using this method to fetch all Schedules from the Firebase FireStore
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSchedules() ;
}

class ScheduleApis implements IScheduleApis {
  FirebaseFirestore _firestore;
  ScheduleApis({required FirebaseFirestore firestore}) : _firestore = firestore;

  /// We are using this typeDef to shorten the length of actual return type
  /// which is FutureEither<void> , just to handle both the data and the errors.
  /// In the Right() it takes the data, and In the Left() It takes errors.

  @override
  FutureEitherVoid createSchedule({required ScheduleModel scheduleModel,})async {
    try{
      await _firestore.
      collection(FirebaseConstants.studentScheduleCollection).
      doc(scheduleModel.scheduleId).
      set(scheduleModel.toMap());

      return const Right(null);
    }on FirebaseException catch(e, stackTrace){

      if (kDebugMode) {
        print(stackTrace);
      }
      /// We are using Failure Class to format the error.
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  /// In case of Streams, we dont use TypeDefs as the riverpod handles the data
  /// and errors very effectively
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSchedules() {
    return _firestore.collection(FirebaseConstants.studentScheduleCollection).snapshots();
  }

}
