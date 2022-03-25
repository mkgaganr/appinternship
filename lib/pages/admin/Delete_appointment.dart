import 'package:clinic/pages/admin/appointment_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeleteAppointment extends StatefulWidget {
  final DocumentSnapshot data;
  final String id;
  const DeleteAppointment({ Key? key,required this.data, required this.id }) : super(key: key);

  @override
  State<DeleteAppointment> createState() => _EditAppointmentState();
}

class _EditAppointmentState extends State<DeleteAppointment> {
  String field1 = "";
  String field2 = "";
  String field3 = "";
  String field4 = "";
  void initState() {
    super.initState();
    field1 = widget.data['doctor name'];
    field2 = widget.data['hospital description'];
    field3 = widget.data['hospital location'];
    field4 = widget.data['time'];
  }
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
          "Delete Appointments",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
      body: Center(

        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: TextEditingController()..text = widget.data['doctor name'],
                onChanged: (value){
                  field1 = value;
                },
              ),
              TextField(
                controller: TextEditingController()..text = widget.data['hospital description'],
                onChanged: (value){
                  field2 = value;
                },
              ),
              TextField(
                controller: TextEditingController()..text = widget.data['hospital location'],
                onChanged: (value){
                  field3 = value;
                },
              ),
              TextField(
                controller: TextEditingController()..text = widget.data['time'],
                onChanged: (value){
                  field4 = value;
                },
              ),

              ElevatedButton(onPressed: () async {
                await FirebaseFirestore.instance.collection("appointment").doc(widget.id).delete();
                Fluttertoast.showToast(msg: "Delete Successful");
                Navigator.of(context).pop();

              },
                child: Text("Delete Data"),
              ),
            ],
          ),
        ),
      ),

    );
  }
}