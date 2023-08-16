import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/datetime_package/datetime_picker_widgets/date_picker_widget.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../staff_home/widgets/staff_appbar.dart';
import '../wiedgets/attendance_course_card.dart';

class AttendenceTrackStaffStreen extends StatelessWidget {
  const AttendenceTrackStaffStreen({Key? key}) : super(key: key);

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
                SizedBox(height: 28.h,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return const AttendanceCourseCard();
                  },
                ),
                SizedBox(height: 38.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
