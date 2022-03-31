import 'package:clinic/pages/admin/Delete_hospital.dart';
import 'package:clinic/pages/admin/add_hospital.dart';
import 'package:clinic/pages/admin/edit_hospital.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class HospitalList extends StatefulWidget {
  const HospitalList({ Key? key }) : super(key: key);

  @override
  State<HospitalList> createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {

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
          "Posted Hospitals",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('test').snapshots(),
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
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  leading: Icon(Icons.local_hospital),

                  
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text('Hospital name:'),
                            Text(Hospital['field1']),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                      child:Row(
                        children: [
                          Text('City:'),
                          Text(Hospital[ 'City']),
                        ],
                      ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text('Hospital description:'),
                            Text(Hospital[ 'field2']),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                      child:Row(
                        children: [
                          Text('Hospital location:'),
                          Text(Hospital['field3']),
                        ],
                      ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text('No of beds:'),
                            Text(Hospital['noofbeds'].toString()),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return EditHospital(data: Hospital, id: snapshot.data!.docs[index].id );
                        },
                        ),
                        );
                      },
                        child: Text("Update"),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return DeleteHospital(data: Hospital, id: snapshot.data!.docs[index].id );
                        },
                        ),
                        );
                      },
                        child: Text("Delete"),
                      ),

                    ],

                  ) ,

                  onTap: (){

                  },
                ),
              );
            },
          );
        },
      ),
    );


  }
}