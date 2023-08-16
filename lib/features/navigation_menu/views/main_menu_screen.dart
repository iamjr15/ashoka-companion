import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gojek_university_app/commons/common_functions/return_id_from_email.dart';
import 'package:gojek_university_app/features/auth/controller/auth_controller.dart';
import 'package:gojek_university_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:gojek_university_app/features/blind_chat/controller/blind_chat_controller.dart';
import 'package:gojek_university_app/features/navigation_menu/widgets/navigation_page_tile.dart';
import 'package:gojek_university_app/utils/constants/assets_manager.dart';
import 'package:gojek_university_app/utils/constants/font_manager.dart';
import 'package:gojek_university_app/utils/thems/styles_manager.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../../../commons/common_widgets/common_appbar.dart';
import '../../../models/user_model.dart';
import '../../../utils/thems/my_colors.dart';
import '../controller/navigation_controller.dart';

class MainMenuScreen extends ConsumerStatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends ConsumerState<MainMenuScreen> with WidgetsBindingObserver{
  /// This is the Global key for handling side Navigation Bar
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();



  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    initialization();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider.notifier).setUserState(true);
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        ref.read(authControllerProvider.notifier).setUserState(false);
        break;
    }
  }







 /// Here in this method, we are initializing necessary methods
  initialization() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      /// Using controller to set the state of user as On, we will
      /// need this status in the Blind Chat Screen, where we are checking current
      /// active users in the app.

      ref.read(authControllerProvider.notifier).setUserState(true);

      /// if the app closes unexpectedly or some other error it will clear available status and matched user
      ref.read(blindChatControllerProvider.notifier).setMyAvailableState(isAvailable: false);
      ref.read(blindChatControllerProvider.notifier).resetMatchedUserIdForMyself();

      /// This is to get the current user data model. And then save it to the
      /// controller so that we could access it anywhere in the app using
      /// dependency injection
      final authCtr = ref.read(authControllerProvider.notifier);
      UserModel userModel = await authCtr.getCurrentUserInfo();

      final authNotifierProvider = ref.read(authNotifierCtr.notifier);
      authNotifierProvider.setUserModelData(userModel);
    });
  }

  /// Method to logout the current user
  logout(WidgetRef ref, BuildContext context) async {
    final authCtr = ref.read(authControllerProvider.notifier);
    await authCtr.logoutStudent(context: context);
  }


  /// Method to build the side Menu Bar Items.
  buildMenu() {
    final navCtr = ref.watch(navigationController);
    final authNotifierProvider = ref.watch(authNotifierCtr);
    String name = authNotifierProvider.userModel?.name ?? 'Richard';
    String? profilePic = authNotifierProvider.userModel?.profileImage;
    String id = authNotifierProvider.userModel!=null ?returnIdFromEmail(authNotifierProvider.userModel!.email): '';
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 50.h, right: 46.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              width: 70.w,
              height: 70.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: profilePic != null
                  ? CachedNetworkImage(
                      imageUrl: profilePic,
                      imageBuilder: (context, imageProvider) => Container(
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
                              child: const CircularProgressIndicator())),
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
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 38.h,),
                Text(
                  'hello $name!',

                  style: getBoldStyle(
                    color: MyColors.textColor,
                    fontSize: MyFonts.size20,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  id,
                  style: getBoldStyle(
                    color: MyColors.textColor,
                    fontSize: MyFonts.size16,
                  ),
                ),
                SizedBox(
                  height: 70.h,
                ),
                NavigationPageTile(
                  onPageTap: () {
                    navCtr.setIndex(0);
                    _sideMenuKey.currentState?.closeSideMenu();
                  },
                  iconPath: AppAssets.profileIcon,
                  pageName: 'my profile',
                ),
                NavigationPageTile(
                  onPageTap: () {
                    navCtr.setIndex(1);
                    _sideMenuKey.currentState?.closeSideMenu();
                  },
                  iconPath: AppAssets.calanderIconNew,
                  pageName: 'schedule',
                ),
                NavigationPageTile(
                  onPageTap: () {
                    navCtr.setIndex(2);
                    _sideMenuKey.currentState?.closeSideMenu();
                  },
                  iconPath: AppAssets.chatIconNew,
                  pageName: 'blindchat',
                ),

                NavigationPageTile(
                  onPageTap: () {
                    navCtr.setIndex(3);
                    _sideMenuKey.currentState?.closeSideMenu();
                  },
                  iconPath: AppAssets.infoIconNew,
                  pageName: 'resource',
                ),
                NavigationPageTile(
                  onPageTap: () {
                    navCtr.setIndex(4);
                    _sideMenuKey.currentState?.closeSideMenu();
                  },
                  iconPath: AppAssets.starIconNew,
                  pageName: 'credits',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SideMenu(
        key: _sideMenuKey,
        background: MyColors.newLightYellowColor ,
        menu: buildMenu(),
        closeIcon: Icon(Icons.close, size: 28.h, color: MyColors.textColor),
        type: SideMenuType.shrinkNSlide,
        inverse: true,
        child: Scaffold(
          body: SafeArea(
            top: false,
            child: SizedBox(
              height: 932.h,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Stack(
                  children: [
                    /// Using this consumer to get the index of the current screen in the
                    /// Main Screen.
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        final navCtr = ref.watch(navigationController);
                        return Column(
                          children: [
                            navCtr.screens[navCtr.index],
                          ],
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          /// Here first we are accessing the controller, then
                          /// we are accessing the index of current screen,
                          /// based on that we are showing it to the user.
                          final navCtr = ref.watch(navigationController);
                          return CommonAppbar(
                            title: navCtr.appbarHeadings[navCtr.index],
                            titleColor: navCtr.screenColors[navCtr.index],
                            onMenuTap: () {
                              final _state = _sideMenuKey.currentState!;
                              if (_state.isOpened) {
                                _state.closeSideMenu();
                              } else {
                                _state.openSideMenu();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
