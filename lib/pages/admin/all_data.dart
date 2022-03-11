import 'package:hmsf_intern/pages/admin/edit_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HospitalList extends StatefulWidget {


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
          "Update Hospitals",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('test').snapshots(),
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
              DocumentSnapshot Hospital = snapshot.data.documents[index];
              return ListTile(
                leading: Icon(Icons.local_hospital),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(Hospital['field1']),
                    Text(Hospital['field2']),
                    Text(Hospital['field3']),
                    Text(Hospital['noofbeds']),
                  ],

                ) ,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return EditHospital(data: Hospital, id: snapshot.data.documents[index].id );
                  },
                  ),
                  );
                },
              );
            },
          );
        },
      ),
    );


  }
}