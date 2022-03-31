import 'package:clinic/components/tosat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerifyEmailPage extends StatefulWidget {
  final User user;
  const VerifyEmailPage({Key? key, required this.user}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Email"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await widget.user.sendEmailVerification().whenComplete(() {
              DisplayToast("Please Verify your email");
              Navigator.pop(context);
            });
          },
          child: Text("Send verification email"),
        ),
      ),
    );
  }
}
