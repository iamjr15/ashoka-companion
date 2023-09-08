import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/features/schedule/controller/schedule_controller.dart';
import 'package:gojek_university_app/features/schedule_onclick/widgets/event_stepper_tile.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/common_circle_widget.dart';
import '../../../utils/constants/assets_manager.dart';
import '../../../utils/constants/font_manager.dart';
import '../../schedule/data/models/event_model.dart';

class ScheduleOnClickScreen extends StatelessWidget {
  final List<EventModel> eventModels;
  const ScheduleOnClickScreen({Key? key, required this.eventModels}) : super(key: key);

  final List<Color> eventColors = const [
    MyColors.splashColor,
    MyColors.orignalBlueColor,
    MyColors.yellowStarColor,
    MyColors.greenColor,
    MyColors.purpleColor,
    MyColors.pinkColor,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 812.h,
          child: Stack(
            children: [
              Positioned(
                  top: -82.h,
                  right: -69.w,
                  child: const CommonCircleWidget(circlePath: AppAssets.redCircle,)
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.h, left: 25.w, bottom: 25.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 385.w,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(100.r),
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 50.w,
                        height: 50.w,
                        padding: EdgeInsets.all(15.spMin),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.redColor,
                          gradient: RadialGradient(
                            colors: [
                              MyColors.reddishColor,
                              MyColors.redColor,
                            ],
                          )
                        ),
                        child: Image.asset(AppAssets.arrowLeftShort,),
                      ),
                    ),
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        final scheduleCtr = ref.watch(scheduleController);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 35.h,),
                            Text('Monday', style: getBoldStyle(
                              fontSize: MyFonts.size30,
                            ),),
                            SizedBox(height: 8.h,),
                            Text('Monday', style: getMediumStyle(
                                fontSize: MyFonts.size16,
                                color: MyColors.secondaryTextColor
                            ),),
                          ],
                        );
                      },

                    ),
                    ListView.builder(
                      itemCount: eventModels.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        EventModel eventModel = eventModels[index];
                        bool isLastIndex = index == eventModels.length - 1;
                        return EventStepperTile(
                          eventName: eventModel.eventName,
                          eventLocation: eventModel.location,
                          eventTime: eventModel.time,
                          isFirst: isLastIndex,
                          isLast: isLastIndex,
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
