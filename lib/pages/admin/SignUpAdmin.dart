import 'package:clinic/pages/admin/admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/my_button.dart';

class SignUpAdminPage extends StatefulWidget {
  const SignUpAdminPage({ Key? key }) : super(key: key);

  @override
  State<SignUpAdminPage> createState() => _SignUpAdminPageState();
}

class _SignUpAdminPageState extends State<SignUpAdminPage> {
  bool visibility = true;
  String fullname = "";
  String email = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0.0,
        title: Text(
          "Add admin",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 20,
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
                          });
                          await FirebaseFirestore.instance
                              .collection("admin")
                              .add({
                            "name": fullname,
                            "email":email,
                            "uid": value.user!.uid
                          }).then((value) {
                            FirebaseAuth.instance.currentUser!.updateDisplayName(fullname);
                            Fluttertoast.showToast(
                                msg: "Added Successfully");
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Admin()));
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