import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:gojek_university_app/commons/common_widgets/custom_arrow_button.dart';
import 'package:gojek_university_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:gojek_university_app/features/blind_chat/controller/blind_chat_controller.dart';
import 'package:gojek_university_app/features/manage_profile/widgets/profile_appbar.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:lottie/lottie.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/common_outline_border_button.dart';
import '../../../commons/common_widgets/padding.dart';
import '../../../utils/constants/assets_manager.dart';

class InstagramHandleScreen extends ConsumerWidget {
  const InstagramHandleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 43.h,
          ),
          ProfileAppBar(
            subtitle: 'INSTAGRAM HANDLE',
            verticalPadding: 20.h,
            onBackTap: (){
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              'add your instagram &\nconnect your\naccount!',
              style:
                  getBoldStyle(color: MyColors.black, fontSize: MyFonts.size28),
            ),
          ),
          const Spacer(flex:3),

          Consumer(
            builder: (context,ref,child) {
              final authNotifierProvider = ref.watch(authNotifierCtr);
              String instagramHandle = authNotifierProvider.userModel?.instagramHandle?? '';
              bool isNotSet= instagramHandle=='';
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    children: [
                      Image.asset(
                        isNotSet?AppAssets.instaNotConnectedIcon:AppAssets.instaConnectedIcon,
                        width: 72.w,
                        height: 72.h,
                      ),
                      padding20,
                      Text(
                        isNotSet?'Instagram not connected':'Instagram connected',
                        style: getMediumStyle(
                            color: MyColors.newYellowColor, fontSize: MyFonts.size16),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),

          const Spacer(flex:4),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: MyColors.newPinkColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.r),
                    topRight: Radius.circular(28.r))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  height: 2.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
                padding48,
                Consumer(
                    builder: (context,ref,child) {
                      final authNotifierProvider = ref.watch(authNotifierCtr);
                      String instagramHandle = authNotifierProvider.userModel?.instagramHandle?? '';
                      bool isNotSet= instagramHandle=='';
                      return Center(
                        child: CustomArrowButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.instagramHandleEditScreen);
                          },
                          buttonText: isNotSet?'add Instagram':"@$instagramHandle",
                          buttonHeight: 70.h,
                          buttonWidth: 352.w,
                          backColor: Colors.white,
                          textColor: MyColors.newPinkColor,
                          icon: isNotSet?null:AppAssets.instaEditIcon,
                        ),
                      );
                    }
                ),
                padding48,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
