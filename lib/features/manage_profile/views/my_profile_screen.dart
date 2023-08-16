import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/features/auth/controller/auth_controller.dart';
import 'package:gojek_university_app/features/manage_profile/widgets/profile_button.dart';
import 'package:gojek_university_app/features/manage_profile/widgets/profile_user_info_widget.dart';
import 'package:gojek_university_app/features/navigation_menu/controller/navigation_controller.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import '../../../commons/common_imports/common_libs.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  logout(WidgetRef ref, BuildContext context) async {
    // final navCtr = ref.read(navigationController);
    // navCtr.setIndex(1);
    final authCtr = ref.read(authControllerProvider.notifier);
    await authCtr.logoutStudent(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sh,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 110.h,
            ),
            const Spacer(
              flex: 3,
            ),
            const ProfileUserInfoWidget(),
            const Spacer(
              flex: 3,
            ),
            MyProfileButton(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.manageInterestsScreen);
              },
              buttonText: 'manage interests',
              buttonIcon: AppAssets.manageInterestIcon,
            ),
            MyProfileButton(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.instagramHandleScreen);
              },
              buttonText: 'manage insta handle',
              buttonIcon: AppAssets.instaHandleIcon,
            ),
            const Spacer(
              flex: 4,
            ),
            Image.asset(
              AppAssets.signInShapesNew,
              width: 140.w,
            ),
            const Spacer(
              flex: 3,
            ),
            Text(
              'an ashoka tech consulting initiative',
              style: getSemiBoldStyle(
                  color: MyColors.black, fontSize: MyFonts.size20),
            ),
            const Spacer(
              flex: 5,
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return Center(
                  child: TextButton(
                    onPressed: () {
                      logout(ref, context);
                    },
                    child: Text(
                      'sign out',
                      style: getSemiBoldStyle(
                        fontSize: MyFonts.size22,
                        color: MyColors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
