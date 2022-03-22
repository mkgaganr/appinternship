import 'package:hmsf_intern/pages/Dashboard/dashboard_page.dart';
import 'package:hmsf_intern/pages/signup/login.dart';
import 'package:hmsf_intern/pages/welcome/welcome_page.dart';
import 'package:hmsf_intern/widgets/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddAppointmentPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<AddAppointmentPage> {
  bool visibility = true;
  String field1 = "";
  String field2 = "";
  String field3 = "";
  String time="";
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
          "Add Appointment",
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
                              hintText: "Doctor name",
                            ),
                            onChanged: (value) {
                              field1 = value;
                            },
                            validator: (value) {
                              value ??= "";
                              if (value.trim() == "") {
                                return "Doctor name required";
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
                              hintText: "Time",
                            ),
                            onChanged: (value) {
                              time =value;
                            },
                            validator: (value) {
                              value ??= "";
                              if (value.trim() == "") {
                                return "time required";
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
                        {"doctor name" :field1,
                          "hospital description":field2,
                          "hospital location":field3,"time":int.parse(time)};
                        Firestore.instance.collection("appointment").add(data);}}, text: "add"
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
