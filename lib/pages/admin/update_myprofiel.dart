import 'package:hmsf_intern/pages/Dashboard/dashboard_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/my_button.dart';

class UpdateProfile extends StatefulWidget {
  final DocumentSnapshot data;
  final String id;
  const UpdateProfile({ Key key, this.data,this.id}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfile> {
  TextEditingController sampledata1 = new TextEditingController();
  TextEditingController sampledata2 = new TextEditingController();
  String name = "";
  String field2 = "";

  @override
  Widget build(BuildContext context) {
    var text;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0.0,
        title: Text(
          "Update profile",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: sampledata1,
                  decoration: InputDecoration(
                      hintText: "Enter new email"
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: sampledata2,
                  decoration: InputDecoration(
                    hintText: "Enter new name"
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                MyButton(onPressed: (){var email;
                Map <String,dynamic> data={};
                Firestore.instance.collection("users").add(data);
                Fluttertoast.showToast(msg: "Updated Successfully");
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DashboardPage()));
                }, text: "Update profile"),
                SizedBox(
                  height: 10.0,
                ),
                //MyButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HospitalList()));}, text: "update"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}