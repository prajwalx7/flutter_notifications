import 'package:flutter/material.dart';
import 'package:flutter_notifications/screens/home_page.dart';
import 'package:flutter_notifications/services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade300,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          ),
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            try {
              final user = await authService.signInWithGoogle();
              if (user != null && context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                );
              }
            } finally {
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }
            }
          },
          child:
              isLoading
                  ? SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                  : Text("Sign In With Google"),
        ),
      ),
    );
  }
}
