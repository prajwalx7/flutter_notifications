import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notifications/home_page.dart';

void main() {
  AwesomeNotifications().initialize('resource://drawable/res_icon', [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for basic tests',
      importance: NotificationImportance.Max,
      channelShowBadge: true,
      defaultColor: Colors.purple.shade200,
    ),
  ], debug: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Notifications',
      home: HomePage(),
    );
  }
}
