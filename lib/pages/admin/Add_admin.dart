import 'package:hmsf_intern/pages/Dashboard/dashboard_page.dart';
import 'package:hmsf_intern/pages/signup/login.dart';
import 'package:hmsf_intern/pages/welcome/welcome_page.dart';
import 'package:hmsf_intern/widgets/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpadmin extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUpadmin> {
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
                  "Add admin credentials",
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
                    if (_formKey.currentState.validate()) {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: email.trim(), password: password.trim())
                          .then((value) async {
                        if (value.user != null) {
                          await Firestore.instance
                              .collection("admin")
                              .add({
                            "name": fullname,
                            "email":email,
                            "uid": value.user.uid
                          }).then((value) {
                            Fluttertoast.showToast(
                                msg: "Added Successfully");
                          });
                        }
                      });
                    }
                  },
                  text: "Add admin",
                ), // MyButton
                SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
