import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/features/blind_chat/chat/controller/chat_controller.dart';
import 'package:gojek_university_app/features/blind_chat/data/blind_chat_apis/blind_chat_apis.dart';
import 'package:gojek_university_app/models/user_model.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:lottie/lottie.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../routes/route_manager.dart';
import '../../../utils/constants/assets_manager.dart';

class BlindTimeupScreen extends ConsumerStatefulWidget {
  const BlindTimeupScreen({Key? key, required this.matchedUser})
      : super(key: key);
  final UserModel matchedUser;

  @override
  ConsumerState<BlindTimeupScreen> createState() => _BlindTimeupScreenState();
}

class _BlindTimeupScreenState extends ConsumerState<BlindTimeupScreen> {
  @override
  void initState() {
    super.initState();
    resetMatch();
    clearChat();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.blindChatFinishScreen,
          arguments: {'matcherUser': widget.matchedUser});
    });
  }

  clearChat() async {
    await ref
        .read(chatControllerProvider)
        .deleteChat(userId: widget.matchedUser.uid);
  }

  resetMatch() async {
    await ref
        .read(blindChatApisProvider)
        .resetMatchedUserIdForBoth(otherUserId: widget.matchedUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: MyColors.yellowLightGradientColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                AppAssets.timeUpAnimation,
                width: 280.w,
                height: 269.h,
              ),
            ),
            SizedBox(
              height: 53.h,
            ),
            Text(
              'time\'s up!',
              style: getBoldStyle(fontSize: MyFonts.size36,isMontserrat: true),
            )
          ],
        ),
      ),
    );
  }
}
