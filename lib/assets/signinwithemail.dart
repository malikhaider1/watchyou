import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchyou/main.dart';
import 'package:watchyou/screens/LoginPage.dart';
import 'package:watchyou/screens/homescreen.dart';
import 'package:watchyou/widgets/showsnackbar.dart';

class EmailSignUp {
  final FirebaseAuth auth;

  EmailSignUp(this.auth);

  Future<void> signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await sendVerificationEmail(context);
      // showDialog(
      //     barrierColor: Colors.black12,
      //     barrierDismissible: false,
      //     context: context,
      //     builder: (context) => const Center(
      //           child: CircularProgressIndicator(
      //             semanticsLabel: 'WatchYou',
      //             strokeWidth: 4.5,
      //             color: Colors.orange,
      //           ),
      //         ));
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message!, context);
    }
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<void> sendVerificationEmail(BuildContext context) async {
    try {
      auth.currentUser!.sendEmailVerification();
      showSnackBar('Email Verification has been Sent Successfully', context);
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message!, context);
    }
  }

  Future<void> loginInWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      if (!auth.currentUser!.emailVerified) {
        showSnackBar("Verification Email has been sent Successfully", context);
        showSnackBar("Check your Spam Folder if email not found", context);
      }
      if (auth.currentUser!.emailVerified) {
        showDialog(
            barrierColor: Colors.black12,
            barrierDismissible: false,
            context: context,
            builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: 'WatchYou',
                    strokeWidth: 4.5,
                    color: Colors.orange,
                  ),
                ));
        navigatorKey.currentState!.popUntil((route) => route.isFirst);
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message!, context);
    }
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}