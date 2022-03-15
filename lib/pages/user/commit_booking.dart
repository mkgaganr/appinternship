import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/my_button.dart';

class CommitAppointmentPage extends StatefulWidget {


  @override
  State<CommitAppointmentPage> createState() => _CommitBookingPageState();
}

class _CommitBookingPageState extends State<CommitAppointmentPage> {
  TextEditingController sampledata1 = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0.0,
        title: Text(
          "Confirm Appointment",
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
                      hintText: "Enter Phone Number"
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                MyButton(onPressed: (){Map <String,dynamic> data={"Name" :FirebaseAuth.instance.currentUser!.displayName,"Email":FirebaseAuth.instance.currentUser!.email,"PhoneNumber":sampledata1.text,"Timestamp":Timestamp.now()};
                Firestore.instance.collection("Bookingsappointment").add(data);
                Fluttertoast.showToast(msg: "Added Successfully");
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Admin()));
                }, text: "Confirm Appointment"),
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