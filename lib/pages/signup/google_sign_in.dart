import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Dashboard/dashboard_page.dart';
import '../welcome/CheckLogin.dart';

class GoogleSignInPovider{

  Future  LoginWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      await FirebaseFirestore.instance
          .collection("users")
          .add({
        "name": value.user!.displayName,
        "uid": value.user!.uid
      }).then((value) {
        Fluttertoast.showToast(
            msg: "Registration Successful");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardPage()),
        );
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CheckLoginPage()),
      );
    });

  }
  Future signInWithGoogle(BuildContext context) async {

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      await FirebaseFirestore.instance
          .collection("users")
          .add({
        "name": value.user!.displayName,
        "uid": value.user!.uid
      }).then((value) {
        Fluttertoast.showToast(
            msg: "Registration Successful");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardPage()),
        );
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CheckLoginPage()),
      );
    });

  }
}
