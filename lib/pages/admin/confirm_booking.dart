import 'package:hmsf_intern/pages/Dashboard/dashboard_page.dart';
import 'package:hmsf_intern/pages/signup/login.dart';
import 'package:hmsf_intern/pages/welcome/welcome_page.dart';
import 'package:hmsf_intern/widgets/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommitBookingPage extends StatefulWidget {
  @override
  final DocumentSnapshot data;
  final String id;
  const CommitBookingPage({ Key key, this.data, this.id }) : super(key: key);
  _CommitBookingPageState createState() => _CommitBookingPageState();
}

class _CommitBookingPageState extends State<CommitBookingPage> {

  String field1 = "";
  String beds="";
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
          "Confirm Booking",
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
                              hintText: "Enter Phone number",
                            ),
                            onChanged: (value) {
                              field1 = value;
                            },
                            validator: (value) {
                              value ??= "";
                              if (value.trim() == "") {
                                return "Phone number required";
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "No of Beds Required",
                            ),
                            onChanged: (value) {
                              beds = value;
                            },
                            validator: (value) {
                              value ??= "";
                              if (value.trim() == "") {
                                return "Beds required";
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),

                MyButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        Map <String,dynamic> data=
                        {"Name" :FirebaseAuth.instance.currentUser!.displayName,"Email":FirebaseAuth.instance.currentUser!.email,"PhoneNumber":field1,"Timestamp":Timestamp.now(),"Status": "waiting","hospital": widget.data['field1'] ,"beds": int.parse(beds),"hospital id": widget.id};
                        Firestore.instance.collection("Bookings").add(data);}}, text: "add"
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