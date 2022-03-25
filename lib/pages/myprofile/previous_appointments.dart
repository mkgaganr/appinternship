import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class PreviousAppointmentsPage extends StatefulWidget {
  const PreviousAppointmentsPage({ Key? key }) : super(key: key);

  @override
  State<PreviousAppointmentsPage> createState() => _PreviousAppointmentsPageState();
}

class _PreviousAppointmentsPageState extends State<PreviousAppointmentsPage> {
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
          "Previous Appointments",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('Appointment Bookings').where("Email", isEqualTo: FirebaseAuth.instance.currentUser!.email).snapshots(),
        builder: (context,AsyncSnapshot snapshot){
        if (snapshot.hasError) {
        // handle error
          return const Text('Error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
        // return progress indicator widget
          return const Center(child: CircularProgressIndicator());
        }
        /*if(!snapshot.hasData){
          return CircularProgressIndicator();
        }*/
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
              // ignore: non_constant_identifier_names
              DocumentSnapshot Bookings = snapshot.data!.docs[index];
              return Card(
              child: ListTile(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 1), 
                    borderRadius: BorderRadius.circular(5)
                    ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(children: [
                        Text("Doctor Name: "),
                        Text(Bookings['Doctor']),
                    ],),
                    Row(
                      children: [
                        Text("Name: "),
                        Text(Bookings['Name']),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Phone: "),
                        Text(Bookings['PhoneNumber']),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Status: "),
                        Text(Bookings['Status']),
                      ],
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