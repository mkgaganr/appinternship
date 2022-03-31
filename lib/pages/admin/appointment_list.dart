import 'package:clinic/pages/admin/edit_appointment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Delete_appointment.dart';
class AppointmentList extends StatefulWidget {
  const AppointmentList({ Key? key }) : super(key: key);

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
          "Posted Appointments",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
            
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('appointment').snapshots(),
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
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context,index){
              DocumentSnapshot Appointment = snapshot.data!.docs[index];
              return Card(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 1), 
                    borderRadius: BorderRadius.circular(5)
                    ),
                    
                  leading: Icon(Icons.description),

                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text('Doctor name:'),
                            Text(Appointment['doctor name']),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text('Hospital description:'),
                            Text(Appointment['hospital description']),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text('Hospital location:'),
                            Text(Appointment['hospital location']),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text('City:'),
                            Text(Appointment['City']),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text('Time:'),
                            Text(Appointment['time']),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return EditAppointment(data: Appointment, id: snapshot.data!.docs[index].id );
                        },
                        ),
                        );
                      },
                        child: Text("Update"),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return DeleteAppointment(data: Appointment, id: snapshot.data!.docs[index].id );
                        },
                        ),
                        );
                      },
                        child: Text("Delete"),
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