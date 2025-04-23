import 'package:awesome_notifications/awesome_notifications.dart';

class LocalNotifications {
  static scheduleNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Simple Notification',
        body: 'Simple Button',
        bigPicture:
            'https://images.unsplash.com/photo-1744000043352-eabd36a2ecb8?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        notificationLayout: NotificationLayout.BigPicture,
      ),
      schedule: NotificationCalendar.fromDate(
        date: DateTime.now().add(const Duration(minutes: 1)),
        preciseAlarm: true, // may increase battery consumption
        allowWhileIdle:
            true, // notification will be delivered even with low battery
      ),
    );
  }

  static Future<void> showNotificationWithActionButtons(int id) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: 'Hey, there',
        body: 'Order now',
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'SUBSCRIBE',
          label: 'Subscribe',
          autoDismissible: true,
        ),
        NotificationActionButton(
          key: 'DISMISS',
          label: 'Dismiss',
          actionType: ActionType.Default,
        ),
      ],
    );
  }

  static cancelScheduledNotification(int id) async {
    await AwesomeNotifications().cancelSchedule(id);
  }
}
