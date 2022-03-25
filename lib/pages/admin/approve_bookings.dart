import 'package:clinic/pages/admin/admin.dart';
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
        stream: FirebaseFirestore.instance.collection('Bookings').snapshots(),
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
          
          
          Map<String,dynamic> userDataMap= {

          };
          int flag = 0;
          if(snapshot.hasData)
          {
            if(snapshot.data.docs.length > 0){       
              
              for(int i=0;i<snapshot.data.docs.length;i++)
              {
                userDataMap = snapshot.data.docs[i].data();
                if(userDataMap['Status'] == "waiting")
                {
                  flag = 1;                  
                }
              }
              if(flag == 0)
              {
                return Center(
                child: Text("No Bookings to Approve",
                style: TextStyle(fontSize: 20.0,),),
                );
              }
            }
              
          } 
          

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              DocumentSnapshot Booking = snapshot.data!.docs[index];
              try{
              if(Booking['Status'] == "waiting")
              {
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
                         Text(Booking['Email'], overflow: TextOverflow.clip,),
                       ],
                      ),
                      Row(
                        children: [
                          Text('Doctor name:'),
                          Text(Booking['Name'], overflow: TextOverflow.clip,),
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
                            await FirebaseFirestore.instance.collection('test').doc(Booking['hospital id']).get()
                            .then((value) {
                              if(value.get('noofbeds')<Booking['beds'])
                              {
                                 Fluttertoast.showToast(msg: 'Requested beds are not available');
                              }
                              else
                              {
                                Map <String,dynamic> data1={"Status": "approved"};
                            FirebaseFirestore.instance.collection("Bookings").doc(Booking.id).update(data1).
                            then((value) 
                            {
                                FirebaseFirestore.instance.collection('test').doc(Booking['hospital id']).update(
                                {
                                  
                                  "noofbeds": FieldValue.increment(-Booking['beds']) ,

                                }
                                );
                            
                              
                                                                      
                                                                              
                            }
                            );
                            Fluttertoast.showToast(msg: "Booking Approved");
                              }
                            });

                              
                      
                        },
                        child: Text("Approve"),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(onPressed: () async {
                        Map <String,dynamic> data1={"Status": "cancelled"};
                        FirebaseFirestore.instance.collection("Bookings").doc(Booking.id).update(data1);
                        Fluttertoast.showToast(msg: "Booking Cancelled");
                        Navigator.of(context).pop();
                      },
                        child: Text("Disapprove"),
                      ),
                    ],

                  ) ,
                ),
              );
            } 
            return SizedBox(height: 0.0,);
            }
            catch(e){
              print(e);
              rethrow;
            }
              
          
            },
          );
        },
      ),
    );
  }
}