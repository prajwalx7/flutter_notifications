import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:flutter/material.dart';

class NotificationController extends ChangeNotifier {
  static final NotificationController _instance =
      NotificationController._internal();
  factory NotificationController() => _instance;
  NotificationController._internal();

  static Future<void> initializeNotifications({required bool debug}) async {
    try {
      await AwesomeNotifications().initialize(null, [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.Max,
          enableVibration: true,
          defaultColor: Colors.redAccent.shade100,
          channelShowBadge: true,
          enableLights: true,
          playSound: true,
        ),
      ], debug: debug);

      await AwesomeNotifications().setListeners(
        onActionReceivedMethod: (ReceivedAction receivedAction) async {
          debugPrint('Notification action received: ${receivedAction.title}');
        },
        onNotificationDisplayedMethod: (
          ReceivedNotification receivedNotification,
        ) async {
          debugPrint('Notification displayed: ${receivedNotification.title}');
        },
      );

      await initializeRemoteNotifications(debug: debug);

      debugPrint('Notifications initialized');
    } catch (e) {
      debugPrint('Error initializing notifications: $e');
    }
  }

  static Future<void> initializeRemoteNotifications({
    required bool debug,
  }) async {
    await AwesomeNotificationsFcm().initialize(
      onFcmTokenHandle: NotificationController.myFcmTokenHandle,
      onFcmSilentDataHandle: NotificationController.mySilentDataHandle,
      licenseKeys: [],
      debug: debug,
    );
  }

  static Future<void> myFcmTokenHandle(String token) async {
    debugPrint('Firebase Token: "$token"');
  }

  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    debugPrint('"SilentData": ${silentData.data}');
  }

  static Future<String> requestFirebaseToken() async {
    if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
      try {
        return await AwesomeNotificationsFcm().requestFirebaseAppToken();
      } catch (exception) {
        debugPrint('$exception');
      }
    }
    return '';
  }
}
