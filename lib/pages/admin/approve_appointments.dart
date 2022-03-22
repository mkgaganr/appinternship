import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Send_Sms.dart';

class ApproveAppointmentsPage extends StatefulWidget {


  @override
  State<ApproveAppointmentsPage> createState() => _ApproveAppointmentsState();
}

class _ApproveAppointmentsState extends State<ApproveAppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0.0,
        title: Text(
          "Approve Appointments",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Appointment Bookings').snapshots(),
        builder: (context,AsyncSnapshot snapshot){
          if (snapshot.hasError) {
            // handle error
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            // return progress indicator widget
            return const Center(child: CircularProgressIndicator());
          }
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index){
              DocumentSnapshot Appointments = snapshot.data.documents[index];
              return Card(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  leading: Icon(Icons.local_hospital),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text('Email:'),
                          Text(Appointments['Email']),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Name:'),
                          Text(Appointments['Name']),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Phone Number:'),
                          Text(Appointments['PhoneNumber']),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Status:'),
                          Text(Appointments['Status']),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Doctor name:'),
                          Text(Appointments['Doctor']),
                        ],
                      ),

                      SizedBox(height: 10),
                      ElevatedButton(onPressed: (){

                      },
                        child: Text("Approve"),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(onPressed: ()=>SendSms(),
                        child: Text("Disapprove"),
                      ),

                    ],

                  ) ,
                ),
              );
            },
          );
        },
      ),
    );
  }
}