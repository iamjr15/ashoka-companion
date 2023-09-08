import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/constants/font_manager.dart';

class EventStepperTile extends StatelessWidget {
  final String eventName;
  final String eventLocation;
  final String eventTime;
  final bool isFirst;
  final bool isLast;
  const EventStepperTile({Key? key, required this.eventName, required this.eventLocation, required this.eventTime, required this.isFirst,  required this.isLast}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 20.w,
          child: Column(
            children: [
              isFirst ? Container(
                width: 19.w,
                height: 19.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.newPinkColor.withOpacity(0.5)
                ),
                child: Transform.scale(
                  scale: 0.4,
                  child: Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MyColors.newPinkColor
                    ),
                  ),
                ),
              ) :
                Container(
                  width: 10.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    border: Border.all(
                      color: MyColors.newPinkColor,
                      width: 2.w
                    )
                  ),
                ),
              Container(
                height: isLast? 50.h : 100.h,
                width: 2.w,
                margin: isFirst? EdgeInsets.only(bottom: 10.h): EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  color: MyColors.newYellowColor,
                ),
              )
            ],
          ),
        ) ,
        SizedBox(width: 15.w,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                minWidth: 265.w
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(eventName, style: getMediumStyle(
                    isMontserrat: true,
                    color: MyColors.black,
                    fontSize: MyFonts.size18
                  ),),
                  SizedBox(width: 30.w,),
                  Row(
                    children: [
                      Text(eventTime, style: getSemiBoldStyle(
                          color: MyColors.black,
                          fontSize: MyFonts.size16
                      ),),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.h,),
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, size: 18.spMin,),
                    SizedBox(width: 4.w,),
                    Text(eventLocation, style: getRegularStyle(
                        color: MyColors.secondaryTextColor,
                        fontSize: MyFonts.size16
                    ),),
                  ],
                ),

              ],
            )
          ],
        )
      ],
    );
  }
}
