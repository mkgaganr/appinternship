import 'package:clinic/components/tosat.dart';
import 'package:clinic/pages/Dashboard/dashboard_page.dart';
import 'package:clinic/pages/signup/login.dart';
import 'package:clinic/pages/signup/signup_page.dart';
import 'package:clinic/pages/welcome/welcome_page.dart';
import 'package:clinic/widgets/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPage extends StatefulWidget {
  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  bool visibility = true;
  String fullname = "";
  String email = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),

                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Email address",
                            ),
                            onChanged: (value) {
                              email = value;
                            },
                            validator: (value) {
                              value ??= "";
                              if (value.trim() != "") {
                                if (!value.trim().contains("@")) {
                                  return "Please enter valid email id";
                                }
                              } else {
                                return "Email id required";
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),

                MyButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email.trim())
                          .then((value) async {
                        Fluttertoast.showToast(
                            msg: "Please check your email for password reset.");
                        while (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }).onError((error, stackTrace) {
                        DisplayToast(error.toString());
                      });
                    }
                  },
                  text: "Reset",
                ), // MyButton
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?\t\t"),
                    TextButton(
                      child: Text("SIGNUP"),
                      onPressed: () {
                        while (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignupPage();
                        }));
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
