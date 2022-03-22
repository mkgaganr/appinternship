import 'package:hmsf_intern/pages/Dashboard/dashboard_page.dart';
import 'package:hmsf_intern/pages/signup/login.dart';
import 'package:hmsf_intern/pages/welcome/welcome_page.dart';
import 'package:hmsf_intern/widgets/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddHospitalsPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<AddHospitalsPage> {
  bool visibility = true;
  String field1 = "";
  String field2 = "";
  String field3 = "";
  String field4 = "";
  String noofbeds="";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0.0,
        title: Text(
          "Add Hospital",
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
                  height: 30,
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
                              hintText: "Hospital name",
                            ),
                            onChanged: (value) {
                              field1 = value;
                            },
                            validator: (value) {
                              value ??= "";
                              if (value.trim() == "") {
                                return "Hospital name required";
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Hospital description",
                            ),
                            onChanged: (value) {
                              field2 = value;
                            },
                            validator: (value) {
                              value ??= "";
                              if (value.trim() == "") {
                                return "Hospital description required";
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "hospital location",
                            ),
                            onChanged: (value) {
                              field3 = value;
                            },
                            validator: (value) {
                              value ??= "";
                              if (value.trim() == "") {
                                return "Hospital location required";
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "no of beds",
                            ),
                            onChanged: (value) {
                              noofbeds =value;
                            },
                            validator: (value) {
                              value ??= "";
                              if (value.trim() == "") {
                                return "beds required";
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),

                MyButton(
                        onPressed: (){
                        if(_formKey.currentState.validate()){
                       Map <String,dynamic> data=
                        {"field1" :field1,
                        "field2":field2,
                        "field3":field3,"noofbeds":int.parse(noofbeds)};
                     Firestore.instance.collection("test").add(data);}}, text: "add"
                ),  // MyButton
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
