import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';



class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream = Firestore.instance.collection('hospitals').snapshots();

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
        builder: (context,AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children:snapshot.data.documents.map((DocumentSnapshot documents) {
            Map<String, dynamic> data = documents.data as Map<String, dynamic>;
            return ListTile(
                leading: Icon(Icons.local_hospital),
            title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Text(data['field1']),
            Text(data['field2']),
            Text(data['field3']),
            Text(data['noofbeds']),
            ],
            ),
            );
          }).toList(),
        );
      },
    ),
    );
  }
}