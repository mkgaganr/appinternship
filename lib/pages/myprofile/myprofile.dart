
import 'package:clinic/pages/myprofile/previous_appointments.dart';
import 'package:clinic/pages/myprofile/previous_bookings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Myprofile extends StatelessWidget
{
  // ignore: prefer_final_fields
  Widget textFromField(String hintText){
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.lightBlueAccent[100],
      ),
      child: ListTile(
        leading: Text(hintText),
      ),
      );
  }
   /* return  TextFormField(
              decoration: InputDecoration(
                filled: true,
                hintText: hintText,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
        ), 
        elevation: 0.0,
        title: Text(
          "My Profile",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream : FirebaseFirestore.instance.collection('users').where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
      
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
          {
             if (snapshot.hasError) {
            // handle error
              return const Text('Error');
            }
            else{
              return const Center(child: CircularProgressIndicator());
            }
            
          } 
          Map<String,dynamic> userDataMap= {

          };
          if(snapshot.hasData)
          {
            if(snapshot.data.docs.length > 0)
              userDataMap = snapshot.data.docs[0].data();
          } 
          else
          {
            return const Text("no data");
          }
          
          

          return SafeArea(
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                    children: [
                        Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                          backgroundImage: AssetImage("images/non_profile.png"),
                          radius: 50,                    
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  textFromField(userDataMap["name"]),
                  SizedBox(height: 10.0,),
                  textFromField(FirebaseAuth.instance.currentUser!.email.toString()),

                  SizedBox(height: 20.0,),
                  
                  ElevatedButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PreviousBookingsPage()));
                  }, 
                  child: Text(
                        "Previous Bookings",
                        style: TextStyle(color: Colors.black45),
                        ),
                  style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlueAccent,
                  
                  textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                              ),
                  
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PreviousAppointmentsPage()));
                  }, 
                  child: Text(
                    "Previous Appointments",
                    style: TextStyle(color: Colors.black45),
                  
                  ),
                  style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlueAccent,
                  textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
           
            ],
          ),
          ),
          );
        }
      ),
    );
  }
}