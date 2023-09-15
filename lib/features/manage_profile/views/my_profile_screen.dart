import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/features/auth/controller/auth_controller.dart';
import 'package:gojek_university_app/features/manage_profile/widgets/custom_button.dart';
import 'package:gojek_university_app/features/manage_profile/widgets/profile_button.dart';
import 'package:gojek_university_app/features/manage_profile/widgets/profile_user_info_widget.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import '../../../commons/common_imports/common_libs.dart';
import '../../auth/view/signin_screen.dart';

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

  registerDeleteAccountRequest(WidgetRef ref, BuildContext context) async {
    await FirebaseFirestore.instance.collection("deletion-requests").add(
      {"userID":FirebaseAuth.instance.currentUser?.uid}
    );

    final authCtr = ref.read(authControllerProvider.notifier);
    await authCtr.logoutStudent(context: context);



    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) {
              return SignInScreen();
            })
    );



  }

  deleteAccount(WidgetRef ref, BuildContext context) async {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 340.h,
          // color: Colors.amber,
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(3.r),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 40.h,
                ),

                Text(
                  "are you sure you want to delete your account?",
                  textAlign: TextAlign.center,
                  style: getBoldStyle(
                    isMontserrat: true,
                    color: MyColors.black,
                    fontSize: MyFonts.size16,
                  ),
                ),

                // const Spacer(
                //   flex: 1,
                // ),
                SizedBox(
                  height: 30.h,
                ),

                Text(
                  "deleting your account will also delete your preferences and other saved details on this app",
                  textAlign: TextAlign.center,
                  style: getMediumStyle(
                    isMontserrat: true,
                    color: MyColors.greyishColor,
                    fontSize: MyFonts.size14,
                  ),
                ),

                SizedBox(
                  height: 30.h,
                ),

                CustomDialogButton(
                    onPressed: (){ Navigator.pop(context);},
                    buttonText: "nope, i’m staying",
                  backColor: MyColors.newPinkColor,
                  fontSize: MyFonts.size14,

                  borderRadius: 42.r,
                  isLoading: ref.watch(authControllerProvider),
                  buttonHeight: 84.h,
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                ),

                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    return Center(
                      child: TextButton(
                        onPressed: () {
                          registerDeleteAccountRequest(ref, context);
                        },
                        child: Text(
                          'delete it anyway',
                          style: getSemiBoldStyle(
                            isMontserrat: true,
                            fontSize: MyFonts.size14,
                            color: MyColors.signInStudentButton,
                          ),
                        ),
                      ),
                    );
                  },
                ),


                // Text('Modal BottomSheet'),
                // ElevatedButton(
                //   child: const Text('Close BottomSheet'),
                //   onPressed: () => Navigator.pop(context),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
      height: 1.sh,
      child:
      Padding(
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
              textAlign: TextAlign.center,
              style: getSemiBoldStyle(
                  color: MyColors.black,
                  fontSize: MyFonts.size20
              ),
            ),
            const Spacer(
              flex: 5,
            ),

            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return Center(
                  child: TextButton(
                    onPressed: () {
                      deleteAccount(ref, context);
                    },
                    child: Text(
                      'delete my account',
                      style: getSemiBoldStyle(
                        fontSize: MyFonts.size22,
                        color: MyColors.signInStudentButton,
                      ),
                    ),
                  ),
                );
              },
            ),

            const Spacer(
              flex: 3,
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
