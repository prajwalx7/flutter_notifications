import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:flutter/material.dart';

class NotificationController extends ChangeNotifier {
  // SINGLETON PATTERN
  static final NotificationController _instance =
      NotificationController._internal();

  factory NotificationController() {
    return _instance;
  }

  NotificationController._internal();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // REMOTE NOTIFICATION INITIALIZATION

  static Future<void> initializeRemoteNotifications({
    required bool debug,
  }) async {
    await AwesomeNotificationsFcm().initialize(
      onFcmSilentDataHandle: NotificationController.mySilentDataHandle,
      onFcmTokenHandle: NotificationController.myFcmTokenHandle,
      onNativeTokenHandle: NotificationController.myNativeTokenHandle,
      licenseKeys: [],
      debug: debug,
    );
  }

  static void showSnackbar(String message) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blueAccent,
        ),
      );
    }
  }

  /// Executes in background when silent data arrives
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    showSnackbar('Silent data received');
    debugPrint('"SilentData": ${silentData.data}');
  }

  /// Called when a new FCM token is received
  static Future<void> myFcmTokenHandle(String token) async {
    showSnackbar('FCM token received');
    debugPrint('Firebase Token: "$token"');
  }

  /// Called when a new native token is received
  static Future<void> myNativeTokenHandle(String token) async {
    showSnackbar('Native token received');
    debugPrint('Native Token: "$token"');
  }

  /// Request FCM Token
  static Future<String> requestFirebaseToken() async {
    if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
      try {
        return await AwesomeNotificationsFcm().requestFirebaseAppToken();
      } catch (exception) {
        debugPrint('$exception');
      }
    } else {
      debugPrint('Firebase is not available on this project');
    }
    return '';
  }
}
