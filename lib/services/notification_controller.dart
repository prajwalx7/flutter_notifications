import 'package:awesome_notifications/awesome_notifications.dart';
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

  static Future<void> initializeLocalNotifications({
    required bool debug,
  }) async {
    await AwesomeNotifications().initialize(
      null,
      // 'resource://drawable/res_naruto.png',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.Max,
          // defaultPrivacy: NotificationPrivacy.Secret,
          enableVibration: true,
          defaultColor: Colors.redAccent,
          channelShowBadge: true,
          enableLights: true,
          // icon: 'resource://drawable/res_naruto',
          // playSound: true,
          // soundSource: 'resource://raw/naruto_jutsu',
        ),
        NotificationChannel(
          channelGroupKey: "chat_tests",
          channelKey: "chats",
          channelName: "Group chats",
          channelDescription:
              'This is a simple example channel of a chat group',
          channelShowBadge: true,
          importance: NotificationImportance.Max,
        ),
      ],
      debug: debug,
    );
  }

  // Event Listeners
  static Future<void> initializeEventListeners() async {
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
  }

  static void showSnackbar(String message) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.purple.shade100,
        ),
      );
    }
  }

  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    bool isSilentAction =
        receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction;
    debugPrint(
      '${isSilentAction ? 'Silent action' : 'Action'} notification recieved',
    );
    print('received Action: ${receivedAction.toString()}');

    if (receivedAction.buttonKeyPressed == 'SUBSCRIBE') {
      print('Subscribed');
    } else if (receivedAction.buttonKeyPressed == 'DISMISS') {
      print('Dismiss button pressed');
    }
    showSnackbar(
      '${isSilentAction ? 'Silent action' : 'Action'} notification recieved',
    );
  }

  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedAction,
  ) async {
    debugPrint('Notification created');
    showSnackbar('Notification created');
  }

  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedAction,
  ) async {
    debugPrint('Notification displayed');
    showSnackbar('Notification displayed');
  }

  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    debugPrint('Notification dismissed');
    showSnackbar('Notification dismissed');
  }

  // REMOTE NOTIFICATION INITIALIZATION

  // static Future<void> initializeRemoteNotifications({
  //   required bool debug,
  // }) async {
  //   await AwesomeNotificationsFcm().initialize(
  //     onFcmSilentDataHandle: NotificationController.mySilentDataHandle,
  //     onFcmTokenHandle: NotificationController.myFcmTokenHandle,
  //     onNativeTokenHandle: NotificationController.myNativeTokenHandle,
  //     licenseKeys: [],
  //     debug: debug,
  //   );
  // }

  // static void showSnackbar(String message) {
  //   final context = navigatorKey.currentContext;
  //   if (context != null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(message),
  //         behavior: SnackBarBehavior.floating,
  //         backgroundColor: Colors.blueAccent,
  //       ),
  //     );
  //   }
  // }

  // /// Executes in background when silent data arrives
  // static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
  //   showSnackbar('Silent data received');
  //   debugPrint('"SilentData": ${silentData.data}');
  // }

  // /// Called when a new FCM token is received
  // static Future<void> myFcmTokenHandle(String token) async {
  //   showSnackbar('FCM token received');
  //   debugPrint('Firebase Token: "$token"');
  // }

  // /// Called when a new native token is received
  // static Future<void> myNativeTokenHandle(String token) async {
  //   showSnackbar('Native token received');
  //   debugPrint('Native Token: "$token"');
  // }

  // /// Request FCM Token
  // static Future<String> requestFirebaseToken() async {
  //   if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
  //     try {
  //       return await AwesomeNotificationsFcm().requestFirebaseAppToken();
  //     } catch (exception) {
  //       debugPrint('$exception');
  //     }
  //   } else {
  //     debugPrint('Firebase is not available on this project');
  //   }
  //   return '';
  // }
}
