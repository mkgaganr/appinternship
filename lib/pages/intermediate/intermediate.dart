import 'package:hmsf_intern/pages/Dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Intermediate extends StatefulWidget {
 

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
      body: Center(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:<Widget> [
              Image.asset('images/admin.png'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return DashboardPage();
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
    );
  }
}