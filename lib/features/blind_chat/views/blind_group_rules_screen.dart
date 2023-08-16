import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/custom_arrow_button.dart';
import '../../../routes/route_manager.dart';
import '../../navigation_menu/controller/navigation_controller.dart';
import '../widgets/rule_tile.dart';

class BlindGroupRulesScreen extends StatelessWidget {
  const BlindGroupRulesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60.h,
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final navCtr = ref.watch(navigationController);
                return GestureDetector(
                  onTap: () {
                    print("TRapped");
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.mainMenuScreen, (route) => false);
                    navCtr.setIndex(2);
                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Image.asset(
                        AppAssets.closeIconImage,
                        width: 20.w,
                        height: 20.h,
                      )),
                );
              },
            ),
            SizedBox(
              height: 40.h,
            ),
            Text(
              'FIND MY PAL',
              style: getExtraBoldStyle(
                  fontSize: MyFonts.size16,
                  color:MyColors.newPinkColor ,isMontserrat: true
              ),
            ),
            SizedBox(
              height: 45.h,
            ),
            Image.asset(
              AppAssets.signInShapesNew,
              width: 140.w,
            ),
            SizedBox(
              height: 45.h,
            ),
            Text(
              'ground rules',
              style: getBoldStyle(fontSize: MyFonts.size40,color: MyColors.black),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 340.w),
              child: Text(
                'before you start finding new friends, please accept a few rules so that eveyone can feel safe and have a good time :)',
                textAlign: TextAlign.start,
                style: getRegularStyle(fontSize: MyFonts.size16),
              ),
            ),
            SizedBox(
              height: 35.h,
            ),
            const RuleTile(
              ruleText: 'keep it respectful and kind',
            ),
            const RuleTile(
              ruleText: 'avoid offensive language, hate speech, bullying, or any form of harassment',
            ),
            const RuleTile(
              ruleText: 'do not share or engage in discussions about sensitive topics that could be hurtful to others',
            ),
            SizedBox(
              height: 120.h,
            ),
            Center(
              child: CustomArrowButton(
                buttonText: 'accept and start',
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.blindFriendSearchScreen);
                },
                buttonHeight: 70.h,
                backColor: MyColors.newPinkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
