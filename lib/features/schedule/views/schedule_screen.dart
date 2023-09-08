import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_widgets/common_circle_widget.dart';
import 'package:gojek_university_app/commons/datetime_package/datetime_picker_widgets/date_picker_timeline.dart';
import 'package:gojek_university_app/features/schedule/controller/schedule_controller.dart';
import 'package:gojek_university_app/features/schedule/data/models/schedule_model.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/loading.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../controller/schedule_state_controller.dart';
import '../data/models/event_model.dart';
import '../widgets/new_schedule_widget.dart';
import '../widgets/schedule_loading_shimmer.dart';
import '../widgets/schedule_widget.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {



  @override
  void initState() {
    super.initState();
    try {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        /// In-case we need to manually upload the scheudles data, we will call
        /// this method here, so it will push all schedules to the firebase.
        /// We just need to call this method when we dont have any data on firebase.
        /// otherwise we will keep it commented

        // uploadInitialSchedules();
      });
    } catch (e, s) {
      print(s);
    }
  }

  /// Method to upload schedules manually.

  // uploadInitialSchedules()async{
  //   final scheduleStateCtr = ref.watch(scheduleStateController.notifier);
  //   final scheduleCtr = ref.watch(scheduleController);
  //   scheduleCtr.scheduleModels.forEach((scheduleModel) async{
  //     await scheduleStateCtr.createScheudule(scheduleModel: scheduleModel);
  //   });
  //
  // }


  @override
  Widget build(BuildContext context) {
    /// Used consumer to constantly listen to the changes in schedules,
    /// If we change anything on firebase , the schedules will automatically get updated!

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        /// Initialized the Schedules Controller here.
        final scheduleNotifierCtr = ref.watch(scheduleController);
        return ref.watch(getAlLSchedulesController).when(
            data: (schedules){
              /// Used WidgetsBinding to wait for the ui build to complete,
              /// after that the method inside of it will get called so to avoid errors.
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                scheduleNotifierCtr.setScheduleModelForDay(models: schedules);
              });
              return
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 160.h,),
                  Padding(
                    padding: EdgeInsets.only(top: 25.h, bottom: 25.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Text('${scheduleNotifierCtr.getTodayDayNameAndDate(scheduleNotifierCtr.todaysSchedule?.dayDate ?? scheduleNotifierCtr.activeDate)} ', style: getBoldStyle(
                            fontSize: MyFonts.size30,
                          ),),
                        ),
                        SizedBox(height: 28.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: DatePicker(
                            /// Here we have made custom Date-picker widget.
                            /// In the line below, we are trying to get three days from the current date.
                            /// In line 90, we are getting the active date from our controller.
                            /// In onDateChange method, when the user select any date,
                            /// we set the active date to that selected date. And the active date
                            /// gets updated in the UI.
                            ///
                            ///
                            daysCount: 10,
                            DateTime.now().add(const Duration(days: 2)),
                            // DateTime.now().subtract(const Duration(days: 3)),



                            initialSelectedDate: scheduleNotifierCtr.activeDate,

                            onDateChange: (DateTime date){
                              scheduleNotifierCtr.setActiveDate(date: date, models: schedules);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 33.h,
                        ),

                        /// Here we are checking if we have any  schedule for today or not,
                        /// if no schedule found, we tell the user that there is no schedule for this day.

                        scheduleNotifierCtr.todaysSchedule?.dayDate == null ? Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 200.h),
                              const Text(
                                'you probably either have a class \n or holiday today :)',
                                textAlign: TextAlign.center, // Aligns the text content within the text widget
                              ),
                            ],
                          ),
                        ) :

                        /// If we have schedule for today, we simply show the schedule widget.
                        const Center(
                          child: NewScheduleWidget(
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              );
            },
            /// While fetching the schedules, if we face any error, the riverpod handles it
            /// and tell the error and stack trace of that issue, based on these two parameters,
            /// we handle the error.
            error: (error, st){
              debugPrintStack(stackTrace: st);
              debugPrint(error.toString());
              return const SizedBox.shrink();
            },
            loading: (){
              /// While fetching the data from firebase, it take a bit,
              /// In that time, we show the loading shimmer widget to the user.
              /// Shimmer widget, just depicts that this page has this kind of structure.
              return ShimmerWidget(
                highlightColor: MyColors.yellowStarColor.withOpacity(0.1),
                baseColor: MyColors.pinkColor.withOpacity(0.1),
              );
            }
        );
      },

    );
  }
}
