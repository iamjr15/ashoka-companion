import 'package:gojek_university_app/utils/constants/assets_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/datetime_package/datetime_picker_widgets/date_picker_widget.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/font_manager.dart';
import '../../staff_home/widgets/staff_appbar.dart';
import '../widgets/course_view_card.dart';

class CaptureAttendenceScreen extends StatelessWidget {
  const CaptureAttendenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppConstants.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StaffAppBar(
                  onMenuTap: (){},
                  title: 'ATTENDANCE TRACKER',
                  onBackTap: (){
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 40.h,),
                DatePicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  daysCount: 7,
                  onDateChange: (DateTime date){
                  },
                ),
                SizedBox(height: 38.h,),
                const CourseViewCard(),
                SizedBox(height: 48.h,),
                Center(
                  child: GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: 352.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                          color: MyColors.newPinkColor,
                          borderRadius: BorderRadius.circular(12.r)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(AppAssets.barCodeScan, width: 24.w, height: 24.h,),
                          Text('Capture attendance', style: getMediumStyle(
                              isMontserrat: true,
                              color: MyColors.white,
                              fontSize: MyFonts.size18
                          ),),
                          Image.asset(AppAssets.arrowStaff, width: 24.w, height: 24.h, color: MyColors.white,),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
