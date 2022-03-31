import 'package:clinic/pages/Dashboard/dashboard_page.dart';
import 'package:clinic/pages/signup/login.dart';
import 'package:clinic/widgets/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'google_sign_in.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                  "Sign up",
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
                              hintText: "Full Name",
                            ),
                            onChanged: (value) {
                              fullname = value;
                            },
                            validator: (value) {
                              value ??= "";
                              if (value.trim() == "") {
                                return "Full name required";
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
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
                        TextFormField(
                          obscureText: visibility,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visibility = !visibility;
                                });
                              },
                              icon: Icon(visibility
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          validator: (value) {
                            value ??= "";
                            if (value.trim() == "") {
                              return "Full name required";
                            }
                          },
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),

                MyButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email.trim(), password: password.trim())
                          .then((value) async {
                        if (value.user != null) {
                          await FirebaseFirestore.instance
                              .collection("users")
                              .add({
                            "name": fullname,
                            "uid": value.user!.uid
                          }).then((value) {
                            Fluttertoast.showToast(
                                msg: "Registration Successful");
                            FirebaseAuth.instance.currentUser!.updateDisplayName(fullname);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardPage()),
                            );
                          });
                        }
                      }).onError((error, stackTrace) {
                        Fluttertoast.showToast(msg: 'This email is already registered');
                      });
                    }
                  },
                  text: "SIGN UP",
                ), // MyButton
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?\t\t"),
                    TextButton(
                      child: Text("LOGIN"),
                      onPressed: () {
                        while (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,

                        ),
                        icon: FaIcon(FontAwesomeIcons.google,color: Colors.red,),
                        onPressed: (){
                          GoogleSignInPovider().signInWithGoogle(context);
                        },label: Text('Sign Up with Google'))
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
