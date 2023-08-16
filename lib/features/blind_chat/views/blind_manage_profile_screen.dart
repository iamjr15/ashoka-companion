import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_widgets/common_outline_border_button.dart';
import 'package:gojek_university_app/commons/common_widgets/custom_button.dart';
import 'package:gojek_university_app/commons/common_widgets/show_toast.dart';
import 'package:gojek_university_app/commons/common_widgets/validator.dart';
import 'package:gojek_university_app/features/auth/controller/auth_controller.dart';
import 'package:gojek_university_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:gojek_university_app/models/user_model.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../widgets/create_interest_chip_widget.dart';
import '../widgets/insta_handle_textfield.dart';
import '../widgets/interest_close_tile_widget.dart';
import '../widgets/interest_tile_list_widget.dart';
import '../widgets/manage_profile_appbar.dart';

class BlindManageProfileScreen extends ConsumerStatefulWidget {
  const BlindManageProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BlindManageProfileScreen> createState() =>
      _BlindManageProfileScreenState();
}

class _BlindManageProfileScreenState
    extends ConsumerState<BlindManageProfileScreen> {
  List<String> interestList = [];
  // final TextEditingController _instaController = TextEditingController();
  GlobalKey<FormState> instaKey = GlobalKey<FormState>();

  bool _isValid = true;
  final RegExp _regex =
      RegExp(r'^[a-zA-Z0-9](?:[a-zA-Z0-9._]{0,28}[a-zA-Z0-9])?$');
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_validateInstagramHandle);
    initializeFields();
  }

  void initializeFields() {
    final authNotifierProvider = ref.read(authNotifierCtr);
    _textEditingController.text =
        authNotifierProvider.userModel!.instagramHandle;
    interestList = authNotifierProvider.userModel!.interests;
  }

  void _validateInstagramHandle() {
    final handle = _textEditingController.text;
    if (_textEditingController.text == '') {
      setState(() {
        _isValid = true;
      });
      return;
    }
    setState(() {
      _isValid = _regex.hasMatch(handle);
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  update(WidgetRef ref) async {
    if (_textEditingController.text == '' || !_isValid) {
      showToast(msg: 'kindly provide a valid instagram handle');
      return;
    }
    final authNotifierProvider = ref.read(authNotifierCtr);
    UserModel userModel = authNotifierProvider.userModel!;
    final authCtr = ref.read(authControllerProvider.notifier);
    await authCtr.updateCurrentUserInfo(
        context: context,
        interests: interestList,
        instagramHandle: _textEditingController.text,
        userModel: userModel);

    //update the userModelProvider after updating the profile
    userModel = await authCtr.getCurrentUserInfo();
    authNotifierProvider.setUserModelData(userModel);
  }

  @override
  Widget build(BuildContext context) {
    final authNotifierProvider = ref.watch(authNotifierCtr);
    String name = authNotifierProvider.userModel?.name ?? 'Richard';
    String? profilePic = authNotifierProvider.userModel?.profileImage;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: 812.h),
            child: Padding(
              padding: EdgeInsets.only(
                top: 35.h,
                left: 25.w,
                bottom: 25.h,
                right: 25.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ManageProfileAppbar(
                    title: 'findmypal',
                    onMenuTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Center(
                    child: CommonOutlineBorderButton(
                      buttonText: 'my profile',
                      onTap: () {},
                      height: 43.h,
                      width: 184.w,
                    ),
                  ),
                  SizedBox(
                    height: 63.h,
                  ),
                  Text(
                    'interests',
                    style: getMediumStyle(fontSize: MyFonts.size20),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  InterestTileListWIdget(
                    interestsList: interestList,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Container(
                    constraints:
                        BoxConstraints(minHeight: 125.h, minWidth: 375.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: MyColors.black, width: 3.w)),
                    child: Column(
                      children: [
                        InterestCloseTileWidget(
                          title: 'interest',
                          onAdd: () async {
                            final List<String> newInterests =
                                await createInterestAddon(context);
                            if (newInterests.isNotEmpty) {
                              for (var element in newInterests) {
                                interestList.add(element);
                              }
                              setState(() {});
                            }
                          },
                          onClose: () {
                            interestList.clear();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 34.h,
                  ),
                  Text(
                    'instagram handle',
                    style: getMediumStyle(fontSize: MyFonts.size20),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Form(
                    key: instaKey,
                    child: InstaHandleTextField(
                      controller: _textEditingController,
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
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: CustomButton(
                      onPressed: () {
                        update(ref);
                      },
                      backColor: MyColors.yellowLightGradientColor,
                      isLoading: ref.watch(authControllerProvider),
                      textColor: MyColors.black,
                      buttonText: 'update profile',
                      borderRadius: 30.r,
                      buttonWidth: 200.w,
                      fontSize: MyFonts.size14,
                      buttonHeight: 42.h,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
