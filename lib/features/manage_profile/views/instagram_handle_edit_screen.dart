import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:gojek_university_app/commons/common_widgets/custom_arrow_button.dart';
import 'package:gojek_university_app/commons/common_widgets/show_toast.dart';
import 'package:gojek_university_app/features/auth/controller/auth_controller.dart';
import 'package:gojek_university_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:gojek_university_app/features/blind_chat/controller/blind_chat_controller.dart';
import 'package:gojek_university_app/features/manage_profile/widgets/instagram_text_field.dart';
import 'package:gojek_university_app/features/manage_profile/widgets/profile_appbar.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/utils.dart';
import 'package:lottie/lottie.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/common_outline_border_button.dart';
import '../../../commons/common_widgets/padding.dart';
import '../../../commons/common_widgets/validator.dart';
import '../../../models/user_model.dart';
import '../../../utils/constants/assets_manager.dart';

class InstagramHandleEditScreen extends ConsumerStatefulWidget {
  const InstagramHandleEditScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<InstagramHandleEditScreen> createState() =>
      _InstagramHandleEditScreenState();
}

class _InstagramHandleEditScreenState
    extends ConsumerState<InstagramHandleEditScreen> {
  final instagramCtr = TextEditingController();
  GlobalKey<FormState> instaKey = GlobalKey<FormState>();

  bool _isValid = true;
  final RegExp _regex =
      RegExp(r'^[a-zA-Z0-9](?:[a-zA-Z0-9._]{0,28}[a-zA-Z0-9])?$');
  @override
  void dispose() {
    instagramCtr.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    instagramCtr.addListener(_validateInstagramHandle);
    initializeFields();
  }

  void initializeFields() {
    final authNotifierProvider = ref.read(authNotifierCtr);
    instagramCtr.text = authNotifierProvider.userModel!.instagramHandle;
  }

  void _validateInstagramHandle() {
    final handle = instagramCtr.text;
    if (instagramCtr.text == '') {
      setState(() {
        _isValid = true;
      });
      return;
    }
    setState(() {
      _isValid = _regex.hasMatch(handle);
    });
  }

  update() async {
    if (instagramCtr.text == '' || !_isValid) {
      showToast(msg: 'kindly provide valid instagram handle');
      return;
    }
    final authNotifierProvider = ref.read(authNotifierCtr);
    UserModel userModel = authNotifierProvider.userModel!;
    final authCtr = ref.read(authControllerProvider.notifier);
    await authCtr.updateCurrentUserInstagramInfo(
        context: context,
        instagramHandle: instagramCtr.text,
        userModel: userModel);

    //update the userModelProvider after updating the profile
    userModel = await authCtr.getCurrentUserInfo();
    authNotifierProvider.setUserModelData(userModel);
  }

  @override
  Widget build(BuildContext context) {
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
            onBackTap: () {
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
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: InstagramHandleTextField(
              controller: instagramCtr,
              hintText: 'enter your instagram handle',
              onChanged: (val) {},
              errorText: _isValid ? null : 'Invalid handle',
              onFieldSubmitted: (val) {},
              obscure: false,
              validatorFn: isValidInstagramHandle,
              leadingIcon: Padding(
                padding: EdgeInsets.only(
                    left: 15.w, top: 15.h, bottom: 15.h, right: 15.w),
                child: Image.asset(
                  AppAssets.instaLogo,
                  width: 19.w,
                  height: 19.h,
                  color: MyColors.black,
                ),
              ),
            ),
          ),
          const Spacer(flex: 6),
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
                Center(
                  child: CustomArrowButton(
                    onPressed: update,
                    buttonText: 'Update Instagram Handle',
                    buttonHeight: 70.h,
                    buttonWidth: 352.w,
                    isLoading: ref.watch(authControllerProvider),
                    backColor: Colors.white,
                    textColor: MyColors.newPinkColor,
                  ),
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
