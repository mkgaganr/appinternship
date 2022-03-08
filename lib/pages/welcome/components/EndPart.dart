import 'package:hmsf_intern/pages/signup/signup_page.dart';
import 'package:flutter/material.dart';

class EndPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff027f47), Color(0xff01a95c)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(04),
          ),
          child: Material(
            child: InkWell(
              onTap: () {
                print("login");
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignupPage();
                }));
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  "LOG In",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
