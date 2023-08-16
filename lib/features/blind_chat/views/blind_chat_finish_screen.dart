import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_widgets/common_outline_border_button.dart';
import 'package:gojek_university_app/features/blind_chat/data/blind_chat_apis/blind_chat_apis.dart';
import 'package:gojek_university_app/features/blind_chat/widgets/finish_chat_insta_widget.dart';
import 'package:gojek_university_app/features/navigation_menu/controller/navigation_controller.dart';
import 'package:gojek_university_app/models/user_model.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/custom_button.dart';
import '../../../routes/route_manager.dart';

class BlindChatFinishScreen extends ConsumerStatefulWidget {
  const BlindChatFinishScreen({Key? key, required this.matchedUser})
      : super(key: key);
  final UserModel matchedUser;

  @override
  ConsumerState<BlindChatFinishScreen> createState() =>
      _BlindChatFinishScreenState();
}

class _BlindChatFinishScreenState extends ConsumerState<BlindChatFinishScreen> {
  @override
  initState() {
    // resetMatch();
    super.initState();
  }

  resetMatch() async {
    await ref
        .read(blindChatApisProvider)
        .resetMatchedUserIdForBoth(otherUserId: widget.matchedUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Text(
                'did you \nhave fun \ntalking to \n${widget.matchedUser.name}?',
                textAlign: TextAlign.start,
                style: getBoldStyle(
                    fontSize: MyFonts.size34,
                    color: MyColors.black,
                    isMontserrat: true),
              ),
            ),
            Spacer(
              flex: 3,
            ),
            FinishChatInstaWidget(instaId: widget.matchedUser.instagramHandle),
            Spacer(
              flex: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: MyColors.secondaryTextColor.withOpacity(0.2),
                        offset: Offset(2.w, 1.h),
                        blurRadius: 12),
                    BoxShadow(
                        color: MyColors.white.withOpacity(0.1),
                        offset: Offset(-1.w, -1.h),
                        blurRadius: 12),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Container(
                    height: 4.h,
                    width: 54.w,
                    decoration: BoxDecoration(
                      color: MyColors.newTextFieldColor,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Text(
                    'want to keep finding new pals?',
                    textAlign: TextAlign.center,
                    style: getBoldStyle(
                        fontSize: MyFonts.size16, isMontserrat: true),
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Center(
                    child: CustomButton(
                      buttonText: 'chat to someone else',
                      buttonWidth: 318.w,
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.blindFriendSearchScreen);
                      },
                    ),
                  ),

                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final navCtr = ref.watch(navigationController);
                      return  Center(
                        child: TextButton(
                          onPressed: () async {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.mainMenuScreen,
                                    (route) => false);
                            navCtr.setIndex(2);
                          },
                          child: Text(
                            'leave session',
                            style: getSemiBoldStyle(
                                fontSize: MyFonts.size14,
                                color: MyColors.newPinkColor,
                                isMontserrat: true),
                          ),
                        ),
                      );
                    },

                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
