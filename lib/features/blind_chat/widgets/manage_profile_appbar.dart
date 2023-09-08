import 'package:gojek_university_app/commons/common_imports/apis_commons.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/constants/assets_manager.dart';
import '../../../utils/constants/font_manager.dart';


class ManageProfileAppbar extends StatelessWidget {
  final String title;
  final VoidCallback onMenuTap;
  const ManageProfileAppbar({Key? key, required this.title, required this.onMenuTap})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: onMenuTap,
            child: Padding(
              padding: EdgeInsets.all(8.0.h),
              child: Container(
                child: Image.asset(
                  AppAssets.arrowRoundBack,
                  height: 18.h,
                  width: 27.w,
                ),
              ),
            )),
        Text(
          title,
          style: getSemiBoldStyle(fontSize: MyFonts.size24),
        ),
        Consumer(
            builder: (context,ref,child) {
              return GestureDetector(
                onTap: (){

                },
                child: QrImageView(
                  data: 'randomString',
                  version: QrVersions.auto,
                  size: 45.h,
                  backgroundColor: Colors.transparent,
                  gapless: false,
                ),
              );
            }
        )
      ],
    );
  }
}
