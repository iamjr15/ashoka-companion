import 'package:gojek_university_app/utils/constants/font_manager.dart';

import '../../../commons/common_imports/common_libs.dart';


/// This is the Event widget we are showing in the home page inside the schedule Widget.

class EventWidget extends StatelessWidget {
  final Color eventColor;
  final String eventName;
  final String eventLocation;
  final String eventTime;

  const EventWidget({Key? key, required this.eventColor, required this.eventName, required this.eventLocation, required this.eventTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 45.w,
            height: 45.h,
            decoration: BoxDecoration(
              color: eventColor,
              shape: BoxShape.circle,
              border: Border.all(
                width: 1.5,
                color: MyColors.textColor
              )
            ),
          ),
          SizedBox(width: 10.w,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(eventName, style: getMediumStyle(
                color: MyColors.secondaryTextColor,
                fontSize: MyFonts.size14
              ),),
              SizedBox(height: 6.h,),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 12.spMin,),
                      SizedBox(width: 4.w,),
                      Text(eventLocation, style: getMediumStyle(
                          color: MyColors.secondaryTextColor,
                          fontSize: MyFonts.size12
                      ),),
                    ],
                  ),
                  SizedBox(width: 30.w,),
                  Row(
                    children: [
                      Icon(Icons.access_time_filled, size: 12.spMin,),
                      SizedBox(width: 4.w,),
                      Text(eventTime, style: getMediumStyle(
                          color: MyColors.secondaryTextColor,
                          fontSize: MyFonts.size12
                      ),),
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
