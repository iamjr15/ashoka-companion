import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:gojek_university_app/commons/common_widgets/show_toast.dart';
import 'package:gojek_university_app/features/blind_chat/controller/blind_chat_controller.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../auth/controller/auth_notifier_controller.dart';
import '../widgets/online_bar.dart';

class BlindChatHomeScreen extends ConsumerWidget {
  const BlindChatHomeScreen({Key? key}) : super(key: key);


  /// Method to start the chat.
  onSwipe(WidgetRef ref, BuildContext context) {
    final authNotifierProvider = ref.watch(authNotifierCtr);
    /// Fetching instagram handle
    String instagramHandle =
        authNotifierProvider.userModel?.instagramHandle ?? '';
    /// Fetching and saving interests from User Model
    List<String> interests = authNotifierProvider.userModel?.interests ?? [];
    /// Checking if the handle or interests are not empty,
    /// if any of these are null , we insist to first update
    /// the profile and then come back for the chat.
    if (instagramHandle == '' && interests.isEmpty) {
      const msg = 'Please setup interests and instagram handle in "my profile" to start!';
      showAwesomeSnackBar(
          context: context,
          title: 'Profile Not Set',
          msg: msg,
          type: ContentType.failure);
      return;
    }
    /// Here we specifically look for instagram handle
    if (instagramHandle == '') {
      const msg =
          'Your instagram handle is not set, please add it in "my profile" to start';
      showAwesomeSnackBar(
          context: context,
          title: 'Instagram Not Set',
          msg: msg,
          type: ContentType.failure);
      return;
    }
    /// Here we specifically look for interests.
    if ((interests.isEmpty)) {
      const msg =
          'Your interests are not set, please setup interests in "my profile" to start';
      showAwesomeSnackBar(
          context: context,
          title: 'Interest Not Set',
          msg: msg,
          type: ContentType.failure);
      return;
    }

    /// After that if everything is perfect,
    Navigator.pushNamed(context, AppRoutes.blindGroupRulesScreen);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          MyColors.yellowDarkGradientColor,
          MyColors.yellowLightGradientColor
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      )),
      child: Column(
        children: [
          SizedBox(
            height: 285.h,
          ),
          ref.watch(fetchOnlineUsersCount).when(
              data: (onlineUsers) {
                return OnlineBar(
                  numberOfOnlinePeople: onlineUsers,
                );
              },
              error: (error, st) => const OnlineBar(
                    numberOfOnlinePeople: 0,
                  ),
              loading: () => const OnlineBar(
                    numberOfOnlinePeople: 0,
                  )),
          SizedBox(
            height: 55.h,
          ),
          const Spacer(),
          SizedBox(
            height: 480.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Positioned(
                //   top: 0,
                //   child: Lottie.asset(
                //     AppAssets.radarAnimation,
                //     width: 328.w,
                //     height: 305.h,
                //   ),
                // ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 322.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.r),
                            topRight: Radius.circular(25.r))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),
                        Container(
                          height: 4.h,
                          width: 54.w,
                          decoration: BoxDecoration(
                            color: MyColors.black,
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          'connect with other \n students randomly from your\n university',
                          textAlign: TextAlign.center,
                          style: getMediumStyle(fontSize: MyFonts.size20),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        // CommonOutlineBorderButton(
                        //   onTap: () {
                        //     Navigator.pushNamed(
                        //         context, AppRoutes.blindManageProfileScreen);
                        //   },
                        //   buttonText: 'manage profile',
                        // ),
                        SizedBox(
                          height: 56.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 55.w),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.r),
                                border: Border.all(
                                    color: MyColors.black, width: 3.w)),
                            child: SwipeButton.expand(
                              thumb: Icon(
                                Icons.keyboard_double_arrow_right,
                                color: MyColors.black,
                                size: 28.sp,
                              ),
                              activeThumbColor: MyColors.white,
                              activeTrackColor:
                                  MyColors.yellowLightGradientColor,
                              thumbPadding: EdgeInsets.all(8.sp),
                              height: 65.h,
                              width: 302.w,
                              onSwipe: () {
                                onSwipe(ref, context);
                              },
                              child: Text(
                                "swipe to start",
                                style: getBoldStyle(
                                    fontSize: MyFonts.size14,
                                    color: MyColors.black),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
