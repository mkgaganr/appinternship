import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                      Text(Appointments['Email']),
                      Text(Appointments['Name']),
                      Text(Appointments['PhoneNumber']),
                      Text(Appointments['Status']),
                      Text(Appointments['Doctor']),
                      SizedBox(height: 10),
                      ElevatedButton(onPressed: (){

                      },
                        child: Text("Approve"),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(onPressed: (){

                      },
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