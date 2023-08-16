import 'package:gojek_university_app/commons/common_imports/apis_commons.dart';
import 'package:gojek_university_app/commons/common_widgets/show_toast.dart';
import 'package:gojek_university_app/features/auth/controller/auth_controller.dart';
import 'package:gojek_university_app/features/navigation_menu/controller/navigation_controller.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../firebase_messaging/firebase_messaging_class.dart';
import '../../utils/constants/assets_manager.dart';
import '../../utils/constants/font_manager.dart';
import '../common_imports/common_libs.dart';

class CommonAppbar extends StatelessWidget {
  final String title;
  final Color titleColor;
  final VoidCallback onMenuTap;
  const CommonAppbar(
      {Key? key,
      required this.title,
      required this.onMenuTap,
      required this.titleColor})
      : super(key: key);

  // sendNotify()async {
  //   MessagingFirebase messagingFirebase = MessagingFirebase();
  //   await messagingFirebase.getRegisterIds();
  //   bool status = await messagingFirebase.pushNotificationsAllDevice(
  //       title: "TQ notification",
  //       body: 'Notification body',
  //       registerIds: messagingFirebase.ids);
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title == 'SCHEDULE'?
             GestureDetector(
                onTap: () async {
                 Navigator.pushNamed(context, AppRoutes.qrCodeScreen);
                },
                child: Image.asset(
                  AppAssets.qrCode,
                  width: 38.w,
                  height: 38.h,
                ),
              ): Consumer(builder: (context, ref, child) {
                return GestureDetector(
                  onTap: () async {
                    final navCtr = ref.watch(navigationController);
                    navCtr.setIndex(1);
                  },
                  child: Image.asset(
                    AppAssets.backArrowNew,
                    width: 38.w,
                    height: 38.h,
                  ),
                );
              }),
              if (title == 'blindchat' || title == 'my profile') ...[
                Text(
                  title,
                  style: getSemiBoldStyle(
                      fontSize: MyFonts.size20, color: MyColors.black),
                ),
              ],
              GestureDetector(
                  onTap: onMenuTap,
                  child: Container(
                    child: Image.asset(
                      AppAssets.menuIconNew,
                      height: 36.h,
                      width: 51.w,
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          if (!(title == 'blindchat'|| title == 'my profile')) ...[
            Text(
              title,
              style: getExtraBoldStyle(
                  fontSize: MyFonts.size16, color: titleColor),
            ),
          ],
        ],
      ),
    );
  }
}
