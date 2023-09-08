import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/features/auth/controller/auth_controller.dart';
import 'package:gojek_university_app/features/auth/view/signin_screen.dart';
import 'package:gojek_university_app/features/manage_profile/views/manage_interests_screen.dart';
import 'package:gojek_university_app/features/navigation_menu/views/main_menu_screen.dart';
import 'package:gojek_university_app/firebase_messaging/firebase_messaging_class.dart';
import 'package:gojek_university_app/firebase_messaging/services/notification_service.dart';
import 'package:gojek_university_app/firebase_options.dart';
import 'package:gojek_university_app/routes/route_manager.dart';
import 'package:gojek_university_app/utils/constants/app_constants.dart';
import 'package:gojek_university_app/utils/thems/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/staff_portal/staff_home/view/staff_portal_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LocalNotificationService.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  MessagingFirebase messagingFirebase = MessagingFirebase();

  @override
  void initState() {
    super.initState();
    initiateFirebaseMessaging();
    saveSkipData();
  }

  void saveSkipData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('skips', 0);
    prefs.setInt('lastSkipTime', 0);
  }

  initiateFirebaseMessaging() async {
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
    });
    messagingFirebase.uploadFcmToken();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    //screenUtil package to make design responsive
    return ScreenUtilInit(
      designSize:
          const Size(AppConstants.screenWidget, AppConstants.screenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          builder: (BuildContext context, Widget? child) {
            final MediaQueryData data = MediaQuery.of(context);
            //Text is generally big on IOS so that why we set text scale factor for IOS to 0.9
            return MediaQuery(
              data: data.copyWith(
                  textScaleFactor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? 0.8
                          : 1),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          title: 'Ashoka Orientation Companion',
          theme: lightThemeData(context),
          onGenerateRoute: AppRoutes.onGenerateRoute,
          // initialRoute:  AppRoutes.blindChatFinishScreen,
          home: ref.watch(userStateStreamProvider).when(
              data: (user) {
                if (user != null) {
                  if (user.providerData[0].providerId == 'google.com') {
                    // return BlindChatChatScreen(name: 'usman asad', uid: 'W82PpYg0jeTSQB1NGNa33allkIE2');
                    return const MainMenuScreen();
                    // return const ManageInterestsScreen();
                  } else {
                    return const StaffPortalHomeScreen();
                  }
                } else {
                  return const SignInScreen();
                }
              },
              error: (error, st) => const SignInScreen(),
              loading: () => const SignInScreen()),
        );
      },
    );
  }
}
