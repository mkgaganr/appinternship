import 'package:clinic/components/tosat.dart';
import 'package:clinic/pages/Dashboard/dashboard_page.dart';
import 'package:clinic/pages/admin/admin.dart';
import 'package:clinic/pages/intermediate/intermediate_page.dart';
import 'package:clinic/pages/signup/forgotpassword.dart';
import 'package:clinic/pages/signup/google_sign_in.dart';
import 'package:clinic/pages/signup/signup_page.dart';
import 'package:clinic/pages/welcome/CheckLogin.dart';
import 'package:clinic/pages/welcome/welcome_page.dart';
import 'package:clinic/widgets/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visibility = true;
  String fullname = "";
  String email = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();
   Map<String,dynamic>? _userData;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection("temp").add({"woo": "hoo"});
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
                  "Log in",
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
                          .signInWithEmailAndPassword(
                              email: email.trim(), password: password.trim())
                          .then((value) async {
                        if (value.user != null) {
                          Fluttertoast.showToast(msg: "Login Successful");

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckLoginPage()),
                          );
                        }
                      }).onError((error, stackTrace) {
                        DisplayToast(error.toString());
                      });
                    }
                  },
                  text: "Login",
                ), // MyButton
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?\t\t"),
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text("Forgot password"),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ResetPage();
                        }));
                      },
                    ),

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
                          GoogleSignInPovider().LoginWithGoogle(context);
                        },label: Text('Login with Google'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<UserCredential> signInFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email', 'name']);
    if (loginResult == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
    }
    else{
      print(loginResult.message);
    }
    final OAuthCredential oAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return FirebaseAuth.instance.signInWithCredential(oAuthCredential);
  }


}
