import 'package:clinic/pages/user/commit_appointment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class BookAppointmentsPage extends StatefulWidget {
  const BookAppointmentsPage({ Key? key }) : super(key: key);

  @override
  State<BookAppointmentsPage> createState() => _BookAppointmentsPageState();
}

class _BookAppointmentsPageState extends State<BookAppointmentsPage> {
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
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              DocumentSnapshot Hospital = snapshot.data!.docs[index];
              return Card(
                color: Colors.blue.shade200,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  leading: Icon(Icons.local_hospital,color: Colors.indigo,),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            new Text('Doctor name : ',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 20
                              ),),
                            new Text(Hospital['doctor name'], overflow: TextOverflow.clip,
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 18
                              ),),
                            Icon(Icons.local_hospital,
                              color: Colors.blueAccent,)
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            new Text('Hospital description : ',
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 20
                              ),),
                            new Text(Hospital['hospital description'], overflow: TextOverflow.clip,
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 18
                              ),),
                            Icon(Icons.description,
                              color: Colors.brown,)
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            new Text('Hospital location : ',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20
                              ),),
                            new Text(Hospital['hospital location'], overflow: TextOverflow.clip,
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18
                              ),),
                            Icon(Icons.location_on,
                              color: Colors.blueGrey,)
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            new Text('Time of appointment : ',
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 20
                              ),),
                            new Text(Hospital['time'], overflow: TextOverflow.clip,
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 18
                              ),),
                            Icon(Icons.access_alarms_sharp,
                              color: Colors.purple,)
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return CommitAppointmentPage(data: Hospital,);
                    },
                    ),
                    );
                      },
                        child: Text("Book",
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 16,
                        ),),
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