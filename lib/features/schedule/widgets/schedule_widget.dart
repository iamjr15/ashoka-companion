import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/features/schedule/data/models/schedule_model.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../routes/route_manager.dart';
import '../../../utils/constants/assets_manager.dart';
import '../../../utils/constants/font_manager.dart';
import '../data/models/event_model.dart';
import 'event_widget.dart';


/// This is Old Schedule Widget, Its no more in use in the app.

class ScheduleWidget extends ConsumerStatefulWidget {
  final ScheduleModel scheduleModel;
  const ScheduleWidget({Key? key, required this.scheduleModel}) : super(key: key);

  @override
  ConsumerState<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends ConsumerState<ScheduleWidget> {
  final List<Color> eventColors = const [
    MyColors.splashColor,
    MyColors.orignalBlueColor,
    MyColors.yellowStarColor,
    MyColors.greenColor,
    MyColors.purpleColor,
    MyColors.pinkColor,
  ];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        width: 283.w,
        height: 454.h,
        decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                  color: MyColors.secondaryTextColor.withOpacity(0.2),
                  offset: Offset(2.w, 1.h),
                  blurRadius: 12
              ),
              BoxShadow(
                  color: MyColors.white.withOpacity(0.1),
                  offset: Offset(-1.w, -1.h),
                  blurRadius: 12
              ),
            ]
        ),
        child: Column(
          children: [
            SizedBox(height: 20.h,),

            SizedBox(
              height: 320.h,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: widget.scheduleModel.dayEvents.length > 4 ? 4 : widget.scheduleModel.dayEvents.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  EventModel evetModel = widget.scheduleModel.dayEvents[index];
                  return EventWidget(
                    eventColor: eventColors[index],
                    eventLocation: evetModel.location,
                    eventName: evetModel.eventName,
                    eventTime: evetModel.time,
                  );
                },
              ),
            ),
            SizedBox(height: 25.h,),
            InkWell(
              highlightColor: MyColors.white,
              splashColor: MyColors.white,
              onTap: (){
                Navigator.pushNamed(
                    context,
                    AppRoutes.scheduleOnClickScreen,
                  arguments: {
                      'eventModels' : widget.scheduleModel.dayEvents
                  }
                );
              },
              child: Padding(
                padding: EdgeInsets.all(8.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('see all events', style: getMediumStyle(
                      fontSize: MyFonts.size14,
                    ),),
                    SizedBox(width: 15.w,),
                    Image.asset(AppAssets.arrowRight, height: 12.h, width: 12.w,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
