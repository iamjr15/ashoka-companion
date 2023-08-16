import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/core/constants/firebase_constants.dart';
import 'package:gojek_university_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:gojek_university_app/features/blind_chat/controller/blind_chat_controller.dart';
import 'package:gojek_university_app/features/blind_chat/widgets/loading_dialog.dart';
import 'package:gojek_university_app/features/navigation_menu/controller/navigation_controller.dart';
import 'package:gojek_university_app/models/user_model.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/loading.dart';
import 'package:lottie/lottie.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../auth/controller/auth_controller.dart';

class BlindFriendSearchScreen extends ConsumerStatefulWidget {
  const BlindFriendSearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BlindFriendSearchScreen> createState() =>
      _BlindFriendSearchScreenState();
}

class _BlindFriendSearchScreenState
    extends ConsumerState<BlindFriendSearchScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _progressValue = 0.0;
  Timer? _timer;
  StreamSubscription<DocumentSnapshot>? _userModelSubscription;

  @override
  void initState() {
    super.initState();
    initiateSearching();
    listenSomeUserMatchedYou();
    startAnimationController();
  }

  startAnimationController() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
          seconds: 90), // Adjust the duration as per your requirement
    );
    _controller.addListener(() {
      setState(() {
        _progressValue = _controller.value * 332; // Range from 0 to 300
      });
    });
    // _timer=Timer(Duration(seconds: 5), () {
    //   Navigator.pushReplacementNamed(context, AppRoutes.blindGroupRulesScreen);
    // });
    _controller.forward();
  }

  listenSomeUserMatchedYou() {
    UserModel myUserModel = ref.read(authNotifierCtr).userModel!;
    final blindChatCtr = ref.read(blindChatControllerProvider.notifier);
    _userModelSubscription = FirebaseFirestore.instance
        .collection(FirebaseConstants.userCollection)
        .doc(myUserModel
            .uid) // Replace 'yourUserId' with the ID of the current user
        .snapshots()
        .listen((snapshot) async {
      if (snapshot.exists) {
        final userModel = UserModel.fromMap(snapshot.data()!);
        if (userModel.matcheduser.isNotEmpty) {
          blindChatCtr.setMyAvailableState(isAvailable: false);
          if (mounted) {
            final authCtr = ref.read(authControllerProvider.notifier);
            UserModel matchedUserModel =
                await authCtr.getUserInfoByUidFuture(userModel.matcheduser);
            Navigator.pushReplacementNamed(
                context, AppRoutes.blindChatChatScreen,
                arguments: {
                  'userModel': matchedUserModel,
                });
          }
        }
      }
    });
  }

  initiateSearching() async {
    final blindChatCtr = ref.read(blindChatControllerProvider.notifier);
    await blindChatCtr.setMyAvailableState(isAvailable: true);
    int availableUsers = await blindChatCtr.getAvailableUsersCount();
    if (availableUsers == 0) {
      await Future.delayed(Duration(seconds: 80));
      await blindChatCtr.setMyAvailableState(isAvailable: false);
      if (mounted) {
        Navigator.pushReplacementNamed(
            context, AppRoutes.blindSearchTimeoutScreen);
      }
      return;
    }

    //get the matched User
    List<UserModel> userModels =
        await blindChatCtr.getFirstAvailableUserForChat();
    if (userModels.isEmpty) {
      await Future.delayed(Duration(seconds: 80));
      await blindChatCtr.setMyAvailableState(isAvailable: false);
      Navigator.pushReplacementNamed(
          context, AppRoutes.blindSearchTimeoutScreen);
      return;
    }
    UserModel matchedUser = userModels.first;

    //set matched user to unavailable
    await blindChatCtr.setMyAvailableState(isAvailable: false);
    await blindChatCtr.setOtherAvailableState(
        isAvailable: false, otherUserId: matchedUser.uid);

    //Set the matchedUserIds for myself and other
    UserModel myUserModel = ref.read(authNotifierCtr).userModel!;
    await blindChatCtr.setMatchedUserIdForBoth(
        otherUserModel: matchedUser,
        myUserModel: myUserModel,
        context: context);

    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.blindChatChatScreen,
          arguments: {
            'userModel': matchedUser,
          });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _cancelDelayedNavigation();
    super.dispose();
  }

  void _cancelDelayedNavigation() {
    if (mounted) {
      _timer?.cancel();
    }
  }

  resetMatch() async {
    showLoadingDialog();
    final blindChatCtr = ref.read(blindChatControllerProvider.notifier);
    await blindChatCtr.resetMatchedUserIdForMyself();
  }

  Future<void> showLoadingDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingProgressDialog(
          text: 'Leaving The Pal Matching',
        );
      },
    ).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final navCtr = ref.watch(navigationController);
    return WillPopScope(
      onWillPop: () async {
        await resetMatch();
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.mainMenuScreen, (route) => false);
        navCtr.setIndex(2);
        return true;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45.h,
            ),
            GestureDetector(
              onTap: () async {
                await resetMatch();
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.mainMenuScreen, (route) => false);
                navCtr.setIndex(2);
              },
              child: Container(
                  margin: EdgeInsets.only(left: 20.w),
                  child: Image.asset(
                    AppAssets.backArrowNew,
                    width: 46.w,
                    height: 46.h,
                  )),
            ),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FIND MY PAL',
                    style: getExtraBoldStyle(
                        fontSize: MyFonts.size16,
                        color: MyColors.newPinkColor,
                        isMontserrat: true),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'aligning your \nstars to \nfind your \nnext pal!',
                    textAlign: TextAlign.start,
                    style: getBoldStyle(fontSize: MyFonts.size28),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  Lottie.asset(
                    AppAssets.searchingForFriendAnimation,
                    width: MediaQuery.of(context).size.width,
                    height: 223.h,
                  ),
                  SizedBox(
                    height: 86.h,
                  ),
                  Center(
                    child: Container(
                      width: 281.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.r),
                        color: MyColors.newPinkLightProgessColor,
                        // border: Border.all(color: MyColors.black, width: 1.w)),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        widthFactor: _progressValue,
                        child: Container(
                          width: _progressValue,
                          decoration: BoxDecoration(
                            color: MyColors.newPinkColor,
                            borderRadius: BorderRadius.circular(17.r),
                            // border: Border.all(color: MyColors.black, width: 1.w)
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        await resetMatch();
                        Navigator.pushNamedAndRemoveUntil(context,
                            AppRoutes.mainMenuScreen, (route) => false);
                        navCtr.setIndex(2);
                      },
                      child: Text(
                        'leave session',
                        style: getSemiBoldStyle(
                            fontSize: MyFonts.size20,
                            color: MyColors.newPinkColor,
                            isMontserrat: true),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
