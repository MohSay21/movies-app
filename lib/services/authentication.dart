import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/main.dart';

final _auth = FirebaseAuth.instance;
final _googleSignin = GoogleSignIn();
final messengerKey = GlobalKey<ScaffoldMessengerState>();

Future<bool> signup(BuildContext context, String email, String password) async {
  _showDialog(context);
  bool result = false;
  try {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password
    );
  } on FirebaseAuthException catch (ex) {
    print(ex.toString());
    _showMessage(ex.message);
    if (ex.message == null) {
      result = true;
    }
  }
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
  return result;
}

Future<bool> signin(BuildContext context, String email, String password) async {
  _showDialog(context);
  bool result = false;
  try {
    await _auth.signInWithEmailAndPassword(
        email: email, password: password,
    );
  } on FirebaseAuthException catch (ex) {
    print(ex.toString());
    _showMessage(ex.message);
    if (ex.message == null) {
      result = true;
    }
  }
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
  return result;
}

Future<void> resetPassword(BuildContext context, String email) async {
  _showDialog(context);
  try {
    await _auth.sendPasswordResetEmail(email: email);
    _showMessage('Password reset link sent to the E-mail');
  } on FirebaseAuthException catch(ex) {
    print(ex.toString());
    _showMessage(ex.message);
    Navigator.of(context).pop();
  }
}

Future<bool> signinWithGoogle(BuildContext context) async {
  _showDialog(context);
  bool result = false;
  try {
    final googleUser = await _googleSignin.signIn();
    if (googleUser == null) return false;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
  } on FirebaseAuthException catch(ex) {
    print(ex.toString());
    _showMessage(ex.message);
    if (ex.message == null) {
      result = true;
    }
  }
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
  return result;
}

Future<void> signout(BuildContext context) async {
  _showDialog(context);
  await _googleSignin.disconnect();
  await _auth.signOut();
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}

_showDialog(BuildContext context) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => Center(child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
      )
  ),
);

_showMessage(String? message) {
  if (message == null) return;
  messengerKey.currentState!
    ..removeCurrentSnackBar()
    ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: message == 'Password reset link sent to the E-mail'
              ? Colors.grey : Colors.redAccent,
          elevation: 0,
        )
    );
}