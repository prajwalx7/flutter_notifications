import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notifications/firebase_options.dart';
import 'package:flutter_notifications/screens/home_page.dart';
import 'package:flutter_notifications/screens/sign_up_screen.dart';
import 'package:flutter_notifications/services/notification_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationController.initializeNotifications(debug: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Notifications',
      home: getInitialScreen(),
    );
  }

  Widget getInitialScreen() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null ? const HomePage() : SignUpScreen();
  }
}
