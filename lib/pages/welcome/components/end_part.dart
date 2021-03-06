import 'package:clinic/pages/signup/login.dart';
import 'package:clinic/pages/signup/signup_page.dart';
import 'package:clinic/widgets/my_button.dart';
import 'package:flutter/material.dart';

class EndPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(
            onPressed: () {
              print("loin");
              while (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            },
            text: "LOG IN"),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            print("login");
            while (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SignupPage();
            }));
          },
          child: Text(
            "SIGNUP",
            style: TextStyle(color: Color(0xff797b7a)),
          ),
        )
      ],
    );
  }
}
