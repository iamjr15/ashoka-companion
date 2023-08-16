import 'package:flutter/material.dart';
import 'package:gojek_university_app/features/auth/view/signin_screen.dart';
import 'package:gojek_university_app/features/auth/view/staff_portal_sigin.dart';
import 'package:gojek_university_app/features/blind_chat/chat/screens/blind_chat_chat_screen.dart';
import 'package:gojek_university_app/features/blind_chat/views/blind_chat_finish_screen.dart';
import 'package:gojek_university_app/features/blind_chat/views/blind_chat_home_screen.dart';
import 'package:gojek_university_app/features/blind_chat/views/blind_group_rules_screen.dart';
import 'package:gojek_university_app/features/blind_chat/views/blind_manage_profile_screen.dart';
import 'package:gojek_university_app/features/blind_chat/views/blind_search_timeout_screen.dart';
import 'package:gojek_university_app/features/blind_chat/views/blind_timeup_screen.dart';
import 'package:gojek_university_app/features/blind_chat/views/friend_searching_screen.dart';
import 'package:gojek_university_app/features/manage_profile/views/instagram_handle_screen.dart';
import 'package:gojek_university_app/features/resources/chatbot/view/resource_chat_bot_screen.dart';
import 'package:gojek_university_app/features/resources/views/campus_map_screen.dart';
import 'package:gojek_university_app/features/resources/views/webview_screen.dart';
import 'package:gojek_university_app/features/schedule/views/schedule_screen.dart';
import 'package:gojek_university_app/features/staff_portal/capture_attendance/views/capture_attendence_screen.dart';
import 'package:gojek_university_app/utils/error_screen.dart';
import '../features/manage_profile/views/instagram_handle_edit_screen.dart';
import '../features/manage_profile/views/manage_interests_screen.dart';
import '../features/navigation_menu/views/main_menu_screen.dart';
import '../features/schedule/views/qr_code_screen.dart';
import '../features/schedule_onclick/views/schedule_onclick_screen.dart';
import '../features/staff_portal/attendance_track_staff/views/attendance_track_staff_screen.dart';
import '../features/staff_portal/staff_home/view/staff_portal_home_screen.dart';
import 'navigation.dart';

class AppRoutes {
//Common Portion
  static const String scheduleScreen = '/scheduleScreen';
  static const String signInScreen = '/signInScreen';
  static const String staffPortalSignInScreen = '/staffPortalSignInScreen';
  static const String staffPortalHomeScreen = '/staffPortalHomeScreen';
  static const String staffAttendenceTrackScreen =
      '/staffAttendenceTrackScreen';
  static const String staffCaptureAttendenceScreen =
      '/staffCaptureAttendenceScreen';

  static const String scheduleOnClickScreen = '/scheduleOnClickScreen';
  static const String mainMenuScreen = '/mainMenuScreen';
  static const String blindChatChatScreen = '/blindChatChatScreen';
  static const String blindChatHomeScreen = '/blindChatHomeScreen';
  static const String blindFriendSearchScreen = '/blindFriendSearchScreen';
  static const String blindSearchTimeoutScreen = '/blindSearchTimeoutScreen';
  static const String blindGroupRulesScreen = '/blindGroupRulesScreen';
  static const String blindTimesUpScreen = '/blindTimesUpScreen';
  static const String blindChatFinishScreen = '/blindChatFinishScreen';
  static const String blindManageProfileScreen = '/blindManageProfileScreen';

  static const String chatExtraScreen = '/chatExtraScreen';

  static const String manageInterestsScreen = '/manageInterestsScreen';
  static const String qrCodeScreen = '/qrCodeScreen';
  static const String instagramHandleScreen = '/instagramHandleScreen';
  static const String instagramHandleEditScreen = '/instagramHandleEditScreen';
  static const String campusMapScreen = '/campusMapScreen';
  static const String webViewScreen = '/webViewScreen';
  static const String resourceChatBotScreen = '/ResourceChatBotScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case scheduleScreen:
        return _buildRoute(const ScheduleScreen());
      case signInScreen:
        return _buildRoute(const SignInScreen());
      case staffPortalSignInScreen:
        return _buildRoute(const StaffPortalSignInScreen());
      case staffPortalHomeScreen:
        return _buildRoute(const StaffPortalHomeScreen());
      case staffAttendenceTrackScreen:
        return _buildRoute(const AttendenceTrackStaffStreen());
      case staffCaptureAttendenceScreen:
        return _buildRoute(const CaptureAttendenceScreen());

      case scheduleOnClickScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(
          ScheduleOnClickScreen(
            eventModels: arguments['eventModels'],
          ),
        );
      case mainMenuScreen:
        return _buildRoute(const MainMenuScreen());

      case blindChatHomeScreen:
        return _buildRoute(const BlindChatHomeScreen());
      case blindFriendSearchScreen:
        return _buildRoute(const BlindFriendSearchScreen());
      case blindSearchTimeoutScreen:
        return _buildRoute(const BlindSearchTimeoutScreen());
      case blindGroupRulesScreen:
        return _buildRoute(const BlindGroupRulesScreen());
      case blindChatChatScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(BlindChatChatScreen(
          otherUserModel: arguments['userModel'],
        ));
      case blindTimesUpScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(BlindTimeupScreen(
          matchedUser: arguments['matcherUser'],
        ));
      case blindChatFinishScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(BlindChatFinishScreen(
          matchedUser: arguments['matcherUser'],
        ));
      case blindManageProfileScreen:
        return _buildRoute(const BlindManageProfileScreen());

      case manageInterestsScreen:
        return _buildRoute(const ManageInterestsScreen());

      case qrCodeScreen:
        return _buildRoute(const QrCodeScreen());
      case instagramHandleScreen:
        return _buildRoute(const InstagramHandleScreen());
      case instagramHandleEditScreen:
        return _buildRoute(const InstagramHandleEditScreen());
      case campusMapScreen:
        return _buildRoute(const CampusMapScreen());
      case webViewScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(WebViewScreen(
          newUrl: arguments['newUrl'],
          pageTitle: arguments['pageTitle'],
        ));
      case resourceChatBotScreen:
        return _buildRoute(const ResourceChatBotScreen());

      default:
        return unDefinedRoute();
    }
  }

  static unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              backgroundColor: Colors.white,
            ));
    return MaterialPageRoute(builder: (_) => const ErrorScreen());
  }

  static _buildRoute(Widget widget, {int? duration = 400}) {
    return forwardRoute(widget, duration);
  }

  static _buildNormalRoute(Widget widget) {
    return MaterialPageRoute(builder: (_) => widget);
  }
}
