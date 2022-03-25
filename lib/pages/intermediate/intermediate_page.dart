import 'package:clinic/pages/admin/admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Dashboard/dashboard_page.dart';

class Intermediate extends StatefulWidget {
  const Intermediate({ Key? key }) : super(key: key);

  @override
  State<Intermediate> createState() => _IntermediateState();
}

class _IntermediateState extends State<Intermediate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Type"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:<Widget> [
                Image.asset('images/admin.png'),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Admin();
                      }));
                    },
                    child: Text("ADMIN")),
                SizedBox(
                  height: 50,
                ),
                Image.asset('images/user.png'),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return DashboardPage();
                      }));
                    },
                    child: Text("MEMBER")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}