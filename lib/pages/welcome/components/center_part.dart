import 'package:flutter/material.dart';

class CenterPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset("assets/hospital.jpg"),
    );
  }
}
