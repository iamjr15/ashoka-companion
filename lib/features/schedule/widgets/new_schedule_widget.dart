import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../schedule_onclick/widgets/event_stepper_tile.dart';
import '../controller/schedule_controller.dart';
import '../data/models/event_model.dart';


/// After th design change, we made this new Schedule Widget for the Schedule Screen.

class NewScheduleWidget extends StatelessWidget {
  const NewScheduleWidget({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 351.w,
      decoration: BoxDecoration(
        color: MyColors.newLightYellowScheduleColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final scheduleNotifierCtr = ref.watch(scheduleController);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
            child: ListView.builder(
              itemCount: scheduleNotifierCtr.todaysSchedule?.dayEvents.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                EventModel eventModel = scheduleNotifierCtr.todaysSchedule!.dayEvents[index];
                bool isLastIndex = index == scheduleNotifierCtr.todaysSchedule!.dayEvents.length - 1;
                bool isFirstIndex = index == 0;
                return EventStepperTile(
                  eventName: eventModel.eventName,
                  eventLocation: eventModel.location,
                  eventTime: eventModel.time,
                  isFirst: isFirstIndex,
                  isLast: isLastIndex,
                );
              },
            ),
          );
        },

      ),
    );
  }
}
