import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gojek_university_app/commons/common_functions/secondsToMMSS.dart';
import 'package:gojek_university_app/core/constants/firebase_constants.dart';
import 'package:gojek_university_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:gojek_university_app/features/blind_chat/chat/controller/chat_controller.dart';
import 'package:gojek_university_app/features/blind_chat/chat/widgets/InterestChipsWidget.dart';
import 'package:gojek_university_app/features/blind_chat/chat/widgets/chat_screen_top_widget.dart';
import 'package:gojek_university_app/features/blind_chat/chat/widgets/chat_timer_widget.dart';
import 'package:gojek_university_app/features/blind_chat/chat/widgets/other_user_left_bottom_sheet.dart';
import 'package:gojek_university_app/features/blind_chat/controller/blind_chat_controller.dart';
import 'package:gojek_university_app/models/user_model.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import '../widgets/bottom_chat_field.dart';
import '../widgets/chat_list.dart';

// Defining the main chat screen widget that extends ConsumerStatefulWidget
class BlindChatChatScreen extends ConsumerStatefulWidget {
  final UserModel otherUserModel;
  const BlindChatChatScreen({Key? key, required this.otherUserModel})
      : super(key: key);

  @override
  ConsumerState<BlindChatChatScreen> createState() =>
      _BlindChatChatScreenState();
}

// State class for the BlindChatChatScreen
class _BlindChatChatScreenState extends ConsumerState<BlindChatChatScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  final timerWidth = 180;
  late AnimationController _controller;
  double _progressValue = 0.0;
  StreamSubscription<DocumentSnapshot>? _userModelSubscription;

  @override
  void initState() {
    super.initState();
    listenSomeMatchUserLeftYou();
    animationController();
  }

  // Initialize the animation controller and timer
  animationController(){
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
          seconds: timerWidth), // Adjust the duration as per your requirement
    );

    _controller.addListener(() {
      setState(() {
        _progressValue = timerWidth -
            _controller.value * timerWidth; // Range from 0 to timeWidth
      });
    });

    // Set up a timer to navigate to a new screen when time is up
    _timer = Timer(Duration(seconds: timerWidth), () {
      Navigator.pushReplacementNamed(context, AppRoutes.blindTimesUpScreen,
          arguments: {'matcherUser': widget.otherUserModel});
    });
    _controller.forward();
  }


  // Listen for updates on whether the other matched user left the chat
  listenSomeMatchUserLeftYou() {
    UserModel myUserModel = ref.read(authNotifierCtr).userModel!;
    final blindChatCtr = ref.read(blindChatControllerProvider.notifier);
    _userModelSubscription = FirebaseFirestore.instance
        .collection(FirebaseConstants.userCollection)
        .doc(myUserModel
        .uid)
        .snapshots()
        .listen((snapshot) async {
      if (snapshot.exists) {
        final userModel = UserModel.fromMap(snapshot.data()!);
        if (userModel.matcheduser.isEmpty) {
          if (mounted) {
            // Check if the timer is close to finishing and handle chat-related actions
            if(_progressValue<timerWidth-5){
              await blindChatCtr.resetOnlyMatchedUserIdForMyself();
              await clearChat();
              bool chatToElse = await otherUserLeft(context,widget.otherUserModel.name);
              if (chatToElse) {
                Navigator.pushReplacementNamed(
                    context, AppRoutes.blindFriendSearchScreen);
              }
            }
          }
        }
      }
    });
  }

  // Clear the chat for the current user and the other user
  clearChat() async {
    await ref.read(chatControllerProvider).deleteChat(
        userId: widget.otherUserModel.uid);
  }

  // Cancel the navigation timer
  void _cancelDelayedNavigation() {
    if (mounted) {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _cancelDelayedNavigation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // Widget for displaying the top section of the chat screen
                ChatScreenTopWidget(
                  name: widget.otherUserModel.name,
                  otherUid: widget.otherUserModel.uid,
                ),
                SizedBox(
                  height: 10.h,
                ),
                // Widget for displaying the chat timer
                ChatTimerWidget(progressValue: _progressValue),
                // Widget for displaying interest chips of the other user
                InterestChipsWidget(interest: widget.otherUserModel.interests),
                SizedBox(
                  height: 10.h,
                ),
                // Widget for displaying the chat messages
                Expanded(
                  child: ChatList(
                    receiverUserId: widget.otherUserModel.uid,
                  ),
                ),
                // Widget for the chat input field
                BottomChatField(
                  receiverUserId: widget.otherUserModel.uid,
                  recieverName: widget.otherUserModel.name,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
