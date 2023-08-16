
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_functions/return_id_from_email.dart';
import 'package:gojek_university_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

import '../../../commons/common_imports/common_libs.dart';

class ProfileUserInfoWidget extends StatelessWidget {
  const ProfileUserInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(builder: (context, ref, child) {
        final authNotifierProvider = ref.watch(authNotifierCtr);
        String name = authNotifierProvider.userModel?.name ?? 'Richard';
        String? profilePic =
            authNotifierProvider.userModel?.profileImage;
        String id = authNotifierProvider.userModel != null
            ? returnIdFromEmail(authNotifierProvider.userModel!.email)
            : '';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 82.w,
                height: 82.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: profilePic != null
                    ? CachedNetworkImage(
                  imageUrl: profilePic,
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                  placeholder: (context, url) => Center(
                      child: SizedBox(
                          width: 30.w,
                          height: 30.h,
                          child:
                          const CircularProgressIndicator())),
                  errorWidget: (context, url, error) => Center(
                      child: SizedBox(
                          width: 30.w,
                          height: 30.h,
                          child: const Icon(Icons.error))),
                )
                    : Image.asset(
                  AppAssets.profileImage,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 20.h,
            ),
            Text(
              name,
              style: getSemiBoldStyle(
                color: MyColors.black,
                fontSize: MyFonts.size28,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              id,
              style: getMediumStyle(
                color: MyColors.secondaryTextColor,
                fontSize: MyFonts.size18,
              ),
            ),
          ],
        );
      }),
    );
  }
}