import 'package:hmsf_intern/pages/welcome/components/center_part.dart';
import 'package:hmsf_intern/pages/welcome/components/end_part.dart';
import 'package:hmsf_intern/pages/welcome/components/top_part.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //top
              TopPart(),
              CenterPart(),
              EndPart(),
            ],
          ),
        ),
      ),
    );
  }
}
