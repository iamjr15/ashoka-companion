import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../commons/common_functions/return_id_from_email.dart';
import '../../../commons/common_imports/apis_commons.dart';
import '../../../commons/common_imports/common_libs.dart';
import '../../auth/controller/auth_notifier_controller.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.newQrScreenBg,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 55.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Image.asset(
                    AppAssets.closeIconImage,
                    width: 20.w,
                    height: 20.h,
                  )),
            ),
            const Spacer(flex: 4,),
            Center(
              child: Container(
                height: 0.6.sh,
                width: 0.8.sw,
                decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                          color: MyColors.newLightGreyColor,
                          blurRadius: 50.spMax,
                          offset: Offset(2, 2)
                      ),
                    ]
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                      child: Image.asset(
                        AppAssets.signInBg,
                        width: double.infinity,
                        height: 140.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Spacer(flex: 4,),
                    Consumer(
                      builder: (context,ref,child) {
                        final authNotifierProvider = ref.watch(authNotifierCtr);
                        String name = authNotifierProvider.userModel?.name ?? '';
                        String instagramHandle = authNotifierProvider.userModel?.instagramHandle?? '';
                        String? email =authNotifierProvider.userModel!.email;
                            authNotifierProvider.userModel?.profileImage;
                        String id = authNotifierProvider.userModel != null
                            ? returnIdFromEmail(authNotifierProvider.userModel!.email)
                            : '';
                        List<String> interests = authNotifierProvider.userModel?.interests ?? [];
                        String qrString="Name:$name;Email:$email;Identifier:$id;insta:@$instagramHandle;interests:$interests";
                        return QrImageView(
                          data: qrString,
                          version: QrVersions.auto,
                          size: 250.h,
                          backgroundColor: MyColors.white,
                          gapless: true,
                        );
                      }
                    ),
                    const Spacer(flex: 4,),
                    Text(
                      'e-pass',
                      style: getSemiBoldStyle(color: MyColors.newPinkColor,fontSize: MyFonts.size24),
                    ),
                    const Spacer(flex: 2,),
                  ],
                ),
              ),
            ),

            const Spacer(flex: 4,),
            Center(
              child: Image.asset(
                AppAssets.signInShapesNew,
                width: 140.w,
              ),
            ),
            const Spacer(flex: 2,),




          ],
        ),
      ),
    );
  }
}
