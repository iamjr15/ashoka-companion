import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/commons/common_widgets/CustomTextFields.dart';
import 'package:gojek_university_app/commons/common_widgets/common_circle_widget.dart';
import 'package:gojek_university_app/commons/common_widgets/custom_button.dart';
import 'package:gojek_university_app/commons/common_widgets/validator.dart';
import 'package:gojek_university_app/features/auth/controller/auth_controller.dart';
import 'package:gojek_university_app/features/auth/widgets/sigin_custom_button.dart';
import 'package:gojek_university_app/features/auth/widgets/staff_sigin_custom_button.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/app_constants.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';

class StaffPortalSignInScreen extends StatefulWidget {
  const StaffPortalSignInScreen({Key? key}) : super(key: key);

  @override
  State<StaffPortalSignInScreen> createState() =>
      _StaffPortalSignInScreenState();
}

class _StaffPortalSignInScreenState extends State<StaffPortalSignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  GlobalKey<FormState> loginInKey = GlobalKey<FormState>();
  var passObscure = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passController.dispose();
    super.dispose();
  }

  login(WidgetRef ref) async {
    if (loginInKey.currentState!.validate()) {
      final authCtr = ref.read(authControllerProvider.notifier);
      await authCtr.signInStaffWithUsernameAndPassword(
          username: _usernameController.text,
          password: _passController.text,
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottomNavigationBar: Consumer(builder: (context, ref, child) {
          return StaffSignInCustomButton(
            onPressed: () {
              login(ref);
            },
            backColor: MyColors.signInStaffButton,
            isLoading: ref.watch(authControllerProvider),
            textColor: MyColors.white,
            buttonText: 'SIGN IN ',
            borderRadius: 0.r,
            buttonHeight: 84.h,
          );
        }),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              Positioned(
                top: 0.h,
                right: 0.w,
                child: Image.asset(
                  AppAssets.staffSignInBg,
                  height: 170.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(AppConstants.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          AppAssets.backArrowNew,
                          width: 46.w,
                          height: 46.h,
                        )),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text('STAFF PORTAL',
                        style: getExtraBoldStyle(
                            fontSize: MyFonts.size16,
                            color: MyColors.newBlueColor,
                            isMontserrat: true)),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'sign in',
                      style: getBoldStyle(
                          fontSize: MyFonts.size40, color: MyColors.black),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Form(
                      key: loginInKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _usernameController,
                            validatorFn: uNameValidator,
                            onChanged: (val) {},
                            onFieldSubmitted: (val) {},
                            obscure: false,
                            hintText: 'enter username',
                            label: 'username',
                            leadingIconPath: AppAssets.userCircleIcon,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomTextField(
                              controller: _passController,
                              onChanged: (val) {},
                              onFieldSubmitted: (val) {},
                              validatorFn: passValidator,
                              obscure: passObscure,
                              label: 'password',
                              leadingIconPath: AppAssets.passwordLockIcon,
                              tailingIcon: passObscure == false
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          passObscure = !passObscure;
                                        });
                                      },
                                      child: Icon(
                                        CupertinoIcons.eye,
                                        color: MyColors.black,
                                        size: 25.h,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          passObscure = !passObscure;
                                        });
                                      },
                                      child: Icon(CupertinoIcons.eye_slash,
                                          color: MyColors.newTextFieldColor,
                                          size: 25.h)),
                              hintText: 'enter password'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
