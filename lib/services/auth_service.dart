import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      await _storeUserData(userCredential.user!);
      return userCredential.user;
    } catch (e) {
      print("Error Signing In $e");
      return null;
    }
  }

  Future<void> _storeUserData(User user) async {
    try {
      String fcmToken =
          await AwesomeNotificationsFcm().requestFirebaseAppToken();
      await AwesomeNotificationsFcm().subscribeToTopic('all_users');
      await _fireStore.collection('users').doc(user.uid).set({
        'email': user.email,
        'name': user.displayName,
        'fcm_tokens': {'token': fcmToken},
      }, SetOptions(merge: true));
      print('Subscribed to all_users topic');
    } catch (e) {
      print("error storing data $e");
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print('Error signing out $e');
    }
  }
}
