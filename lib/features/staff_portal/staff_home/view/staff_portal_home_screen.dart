import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/features/auth/controller/auth_controller.dart';
import 'package:gojek_university_app/utils/constants/app_constants.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

import '../../../../routes/route_manager.dart';
import '../widgets/attendance_tracker_card.dart';
import '../widgets/staff_appbar.dart';

class StaffPortalHomeScreen extends StatelessWidget {
  const StaffPortalHomeScreen({Key? key}) : super(key: key);

  logout(WidgetRef ref, BuildContext context) async {
    final authCtr = ref.read(authControllerProvider.notifier);
    await authCtr.logout(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppConstants.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StaffAppBar(
                onMenuTap: (){},
                title: 'STAFF PORTAL',
                onBackTap: (){

                },
              ),
              const Spacer(
                flex: 1,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.0.w),
                child: Image.asset(
                  AppAssets.signInShapesNew,
                  width: 140.w,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              AttendanceTrackerCard(
                onCardTap: () {
                  Navigator.pushNamed(context, AppRoutes.staffAttendenceTrackScreen);
                },),
              const Spacer(
                flex: 6,
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return Center(
                    child: TextButton(
                      onPressed: () {
                        logout(ref, context);
                      },
                      child: Text(
                        'log out',
                        style: getSemiBoldStyle(
                          fontSize: MyFonts.size20,
                          color: MyColors.newPinkColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
