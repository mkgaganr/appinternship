import 'package:flutter/material.dart';
import 'package:hmsf_intern/widgets/my_button.dart';

class SignupPage extends StatefulWidget {

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "FullName",
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Email address",
                    ),
                  ),
                  TextFormField(
                    obscureText: visibility,
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            visibility = !visibility; 
                              
                          });
                          
                        }, 
                        icon: Icon(
                          visibility? Icons.visibility_off: Icons.visibility),
                        ),
                    ),
                  ),
                ],
                ),
                Column(
                  children: [
                    MyButton(
                    onPressed: (){},
                    text:"SIGN UP",
                    ), // MyButton
                    SizedBox(
                      height: 20,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?\t\t"),
                        Text("LOGIN")
                      ],
                      )
                  ],
                )   
            ],
          ),
        ),
      ),
    );
  }
}