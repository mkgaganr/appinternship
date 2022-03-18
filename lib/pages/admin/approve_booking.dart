import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ApproveBedsPage extends StatefulWidget {


  @override
  State<ApproveBedsPage> createState() => _ApprovePageState();
}

class _ApprovePageState extends State<ApproveBedsPage> {
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
          "Approve Bookings",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Bookings').snapshots(),
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
              // ignore: missing_return
              DocumentSnapshot Booking = snapshot.data.docs[index];
              if(Booking['status'] == Booking['approved']) {
                // ignore: missing_return, missing_return
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
                            Text(Booking['Email']),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Doctor name:'),
                            Text(Booking['Name']),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Phone number:'),
                            Text(Booking['PhoneNumber']),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Status:'),
                            Text(Booking['Status']),
                          ],
                        ),
                        Row(
                          children: [
                            Text('No of beds:'),
                            Text(Booking['beds'].toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Hospital Name:'),
                            Text(Booking['hospital']),
                          ],
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(onPressed: () async {
                          Map <String, dynamic> data1 = {"Status": "approved"};
                          Firestore.instance.collection("Bookings").document(
                              Booking.id).update(data1).
                          then((value) {
                            Firestore.instance.collection('test').document(
                                Booking['hospital id']).update(
                                {

                                  "noofbeds": FieldValue.increment(
                                      -Booking['beds']),

                                }
                            );
                          },
                          );
                          Fluttertoast.showToast(msg: "Update Successful");
                          Navigator.of(context).pop();
                        },
                          child: Text("Approve"),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(onPressed: () {

                        },
                          child: Text("Disapprove"),
                        ),
                      ],

                    ),
                  ),
                );
              }
              else
                {
                 print('no bookings to approve');
                }

            },
          );
        },
      ),
    );
  }
}