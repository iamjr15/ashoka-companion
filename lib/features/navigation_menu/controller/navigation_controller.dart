import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/features/credits/views/credit_screen.dart';
import 'package:gojek_university_app/features/manage_profile/views/my_profile_screen.dart';
import 'package:gojek_university_app/features/resources/views/resources_screen.dart';
import 'package:gojek_university_app/features/schedule/views/schedule_screen.dart';

import '../../blind_chat/views/blind_chat_home_screen.dart';

/// Handle for Navigation Controller Class
final navigationController =
    ChangeNotifierProvider((ref) => NavigationController());

class NavigationController extends ChangeNotifier {
  /// List of screens in the side menu bar.
  List<Widget> screens = [
    const MyProfileScreen(),
    const ScheduleScreen(),
    const BlindChatHomeScreen(),
    const ResourcesScreen(),
    const CreditScreen(),
  ];

  /// List of screen colors we are using in the Heading of that particular screen
  /// based on current screen index.
  List<Color> screenColors = [
    MyColors.newYellowColor,
    MyColors.newYellowColor,
    MyColors.newPinkColor,
    MyColors.newYellowColor,
    MyColors.newPinkColor,
  ];

  /// List of Headings for all screens.
  List<String> appbarHeadings = [
    'my profile',
    'SCHEDULE',
    'blindchat',
    'RESOURCES',
    'CREDITS',
  ];

  /// Index for Side Navigation Menu Bar
  int _index = 1;
  int get index => _index;
  setIndex(int id) {
    _index = id;
    notifyListeners();
  }
}
