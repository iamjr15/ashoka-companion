import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_widgets/custom_button.dart';
import 'package:gojek_university_app/features/auth/widgets/sigin_custom_button.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/app_constants.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:lottie/lottie.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../navigation_menu/controller/navigation_controller.dart';
import '../controller/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  studentGoogleSignIn(WidgetRef ref, BuildContext context) {
    final navCtr = ref.read(navigationController);
    navCtr.setIndex(3);
    final authCtr = ref.read(authControllerProvider.notifier);
    authCtr.signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.authBgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppAssets.signInBg,
            width: double.infinity,
          ),
          Spacer(
            flex: 1,
          ),
          Image.asset(
            AppAssets.signInShapesNew,
            width: 173.w,
          ),
          Spacer(
            flex: 1,
          ),
          Text(
            'the\nashoka\ncompanion',
            textAlign: TextAlign.center,
            style: getBoldSigInHeadingStyle(
                fontSize: MyFonts.size48, color: MyColors.black),
          ),
          Spacer(
            flex: 2,
          ),
          Column(
            children: [
              // SignInCustomButton(           -------------Staff Login Removed
              //   onPressed: () {
              //     Navigator.pushNamed(
              //         context, AppRoutes.staffPortalSignInScreen);
              //   },
              //   buttonText: 'staff sign in',
              //   backColor: MyColors.signInStaffButton,
              //   borderRadius: 0.r,
              //   buttonHeight: 84.h,
              // ),
              Consumer(builder: (context, ref, child) {
                return SignInCustomButton(
                  onPressed: () => studentGoogleSignIn(ref, context),
                  buttonText: 'sign in with ashoka email',
                  backColor: MyColors.signInStudentButton,
                  borderRadius: 42.r,
                  isLoading: ref.watch(authControllerProvider),
                  buttonHeight: 84.h,
                );
              }),
            ],
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
