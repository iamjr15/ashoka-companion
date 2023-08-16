import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/commons/common_widgets/show_toast.dart';
import 'package:gojek_university_app/features/blind_chat/chat/widgets/chat_menu_bottom_sheet.dart';
import 'package:gojek_university_app/features/blind_chat/chat/widgets/leave_chat_bottom_sheet.dart';
import 'package:gojek_university_app/features/blind_chat/chat/widgets/other_user_left_bottom_sheet.dart';
import 'package:gojek_university_app/features/blind_chat/controller/blind_chat_controller.dart';
import 'package:gojek_university_app/features/navigation_menu/controller/navigation_controller.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/loading_dialog.dart';

class ChatScreenTopWidget extends StatefulWidget {
  const ChatScreenTopWidget({
    super.key,
    required this.name,
    required this.otherUid,
  });
  final String name;
  final String otherUid;

  @override
  State<ChatScreenTopWidget> createState() => _ChatScreenTopWidgetState();
}

class _ChatScreenTopWidgetState extends State<ChatScreenTopWidget> {
  int skips = 0;
  DateTime lastSkipTime = DateTime(0);

  @override
  void initState() {
    super.initState();
    loadSkipData();
  }

  void loadSkipData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      int lastSkipTimestamp = prefs.getInt('lastSkipTime') ?? 0;
      lastSkipTime = DateTime.fromMillisecondsSinceEpoch(lastSkipTimestamp);
      final now = DateTime.now();
      final difference = now.difference(lastSkipTime);
      if (difference.inHours >= 24) {
        //to reset skips
        prefs.setInt('skips', 0);
      }
      skips = prefs.getInt('skips') ?? 0;
    });
  }

  Future<void> saveSkipData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('skips', skips);
    prefs.setInt('lastSkipTime', DateTime.now().millisecondsSinceEpoch);
  }

  bool canSkip() {
    final now = DateTime.now();
    final difference = now.difference(lastSkipTime);
    if (difference.inHours >= 24) {
      return true;
    }
    return skips < 3 && difference.inHours <= 24;
  }

  void skipChat(WidgetRef ref) async {
    if (canSkip()) {
      setState(() {
        skips++;
        lastSkipTime = DateTime.now();
      });
      showLoadingDialog(
          loadingText:
              'Closing this session so you can chat with someone else.',
          pop: true);
      await saveSkipData();
      final blindChatCtr = ref.read(blindChatControllerProvider.notifier);
      await blindChatCtr.resetOnlyMatchedUserIdForBoth(
          otherUserId: widget.otherUid);
      Navigator.pop(context);
      Navigator.pushReplacementNamed(
          context, AppRoutes.blindFriendSearchScreen);
    } else {}
  }

  Future<void> showLoadingDialog(
      {required String loadingText, bool pop = false}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadingProgressDialog(
          text: loadingText,
        );
      },
    ).then((value) {
      if (pop) {
        // Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 62.h,
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.r),
              bottomRight: Radius.circular(25.r)),
          boxShadow: [
            BoxShadow(
                color: MyColors.secondaryTextColor.withOpacity(0.2),
                offset: Offset(2.w, 1.h),
                blurRadius: 12),
            BoxShadow(
                color: MyColors.black.withOpacity(0.3),
                offset: Offset(-1.w, -1.h),
                blurRadius: 12),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer(builder: (context, ref, child) {
            return GestureDetector(
              onTap: () async {
                bool leave = await leaveChat(context);
                if (leave) {
                  showLoadingDialog(loadingText: 'Leaving The Chat Session');
                  final navCtr = ref.watch(navigationController);
                  final blindChatCtr =
                      ref.read(blindChatControllerProvider.notifier);
                  await blindChatCtr.resetMatchedUserIdForBoth(
                      otherUserId: widget.otherUid);
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.mainMenuScreen, (route) => false);
                  navCtr.setIndex(2);
                }
              },
              child: Container(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Image.asset(
                    AppAssets.closeIconImage,
                    width: 15.w,
                    height: 15.h,
                  )),
            );
          }),
          Text(
            widget.name,
            style: getBoldStyle(
                fontSize: MyFonts.size17,
                color: MyColors.black,
                isMontserrat: true),
          ),
          Consumer(builder: (context, ref, child) {
            return InkWell(
              onTap: () async {
                bool chatToElse = await chatMenu(context);
                if (chatToElse) {
                  if (canSkip()) {
                    skipChat(ref);
                  } else {
                    showToast(msg: 'You cannot Skip more than 3 times/24hr');
                  }
                }
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Image.asset(
                    AppAssets.chatDotsIcon,
                    height: 20.h,
                  )),
            );
          })
        ],
      ),
    );
  }
}
