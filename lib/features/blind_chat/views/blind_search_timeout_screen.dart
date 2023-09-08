import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_widgets/common_outline_border_button.dart';
import 'package:gojek_university_app/commons/common_widgets/custom_arrow_button.dart';
import 'package:gojek_university_app/features/navigation_menu/controller/navigation_controller.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:lottie/lottie.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../routes/route_manager.dart';

class BlindSearchTimeoutScreen extends StatelessWidget {
  const BlindSearchTimeoutScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 45.h,),
          // Consumer(
          //   builder: (BuildContext context, WidgetRef ref, Widget? child) {
          //     final navCtr = ref.watch(navigationController);
          //     return GestureDetector(
          //       onTap: (){
          //         Navigator.pushNamedAndRemoveUntil(
          //             context,
          //             AppRoutes.mainMenuScreen,
          //                 (route) => false);
          //         navCtr.setIndex(2);
          //       },
          //       child: Container(
          //           padding: EdgeInsets.only(left: 5.w),
          //           child: Image.asset(AppAssets.closeIconImage, width: 15.w, height: 15.h,)),
          //     );
          //   },
          //
          // ),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
                padding: EdgeInsets.only(left: 20.w),
                child: Image.asset(AppAssets.backArrowNew, width: 46.w, height: 46.h,)),
          ),
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                  'aligning your \nstars to \nfind your \nnext pal',
                  textAlign: TextAlign.start,
                  style: getBoldStyle(
                      fontSize: MyFonts.size28
                  ),
                ),
                SizedBox(height: 35.h,),
                Lottie.asset(
                  AppAssets.searchingForFriendAnimation,
                  width: MediaQuery.of(context).size.width,
                  height: 223.h,
                ),
                SizedBox(height: 86.h,),
                Center(
                  child: CustomArrowButton(
                    buttonText: 'try again',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.blindFriendSearchScreen);
                    },
                    buttonHeight: 70.h,
                    backColor: MyColors.newPinkColor,
                  ),
                ),

                SizedBox(height: 30.h,),


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
                              fontSize: MyFonts.size20,
                              color: MyColors.newPinkColor,
                              isMontserrat: true),
                        ),
                      ),
                    );
                  },

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
