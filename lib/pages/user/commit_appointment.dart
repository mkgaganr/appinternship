import 'package:clinic/pages/Dashboard/dashboard_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/my_button.dart';

class CommitAppointmentPage extends StatefulWidget {
  final DocumentSnapshot data;
  
  const CommitAppointmentPage({ Key? key, required this.data, required String id,}) : super(key: key);

  @override
  State<CommitAppointmentPage> createState() => _CommitAppointmentPageState();
}

class _CommitAppointmentPageState extends State<CommitAppointmentPage> {
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
          "Confirm Appointment",
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
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
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
                      ],
                    )),

                MyButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        Map <String,dynamic> data={"Name" :FirebaseAuth.instance.currentUser!.displayName,"Email":FirebaseAuth.instance.currentUser!.email,"PhoneNumber":field1,"Timestamp":Timestamp.now(),"Doctor": widget.data['doctor name'],"Status": "waiting",};
                        FirebaseFirestore.instance.collection("Appointment Bookings").add(data);
                        Fluttertoast.showToast(msg: "Appointment sent for approval");
                        Navigator.of(context).pop();
                        }
                        }, 
                  text: "Confirm Appointmemt"
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