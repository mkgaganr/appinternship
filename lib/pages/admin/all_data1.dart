
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class AppointmentList extends StatefulWidget {


  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
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
          "Book Appointment",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,

          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('appointment').snapshots(),
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
              DocumentSnapshot Appointment = snapshot.data.documents[index];
              return Card(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(5)
                  ),

                  leading: Icon(Icons.description),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(Appointment['doctor name']),
                      Text(Appointment['hospital description']),
                      Text(Appointment['hospital location']),
                      Text(Appointment['time']),
                      new Text(
                        'Click on the icon to book',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.book_online,
                        size: 40,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 10),
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