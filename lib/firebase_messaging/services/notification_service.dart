import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../commons/common_imports/common_libs.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  static void initialize() {

    // void onDidReceiveLocalNotification(
    //     int id, String? title, String? body, String? payload) async {
    //   // display a dialog with the notification details, tap ok to go to another page
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) =>
    //         CupertinoAlertDialog(
    //           title: Text(title ?? ""),
    //           content: Text(body ?? ""),
    //           actions: [
    //             CupertinoDialogAction(
    //               isDefaultAction: true,
    //               child: Text('Ok'),
    //               onPressed: () async {
    //                 Navigator.of(context, rootNavigator: true).pop();
    //                 await Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => SecondScreen(payload),
    //                   ),
    //                 );
    //               },
    //             )
    //           ],
    //         ),
    //   );
    // }
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
          // Handle when a notification is received in the foreground on iOS.
        },
        requestSoundPermission: true, // Request permission to play sound on iOS.
        requestBadgePermission: true, // Request permission to update badge on iOS.
        defaultPresentSound: true,    // Play default sound for notifications.
        defaultPresentBadge: true,    // Update badge for notifications.
        defaultPresentAlert: true,    // Show alert for notifications.
      ),
    );
    _flutterLocalNotificationPlugin.initialize(initializationSettings);
  }



  static void display(RemoteMessage message) async {
    try {
      Random random = Random();
      int id = random.nextInt(1000);

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails("mychanel", "my chanel",
              importance: Importance.max, priority: Priority.high)
      );

      await _flutterLocalNotificationPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails);
    } on Exception catch (e) {
      print('Error>>>$e');
    }
  }
}
