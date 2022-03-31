import 'package:clinic/pages/admin/update_hospital.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeleteHospital extends StatefulWidget {
  final DocumentSnapshot data;
  final String id;
  const DeleteHospital({ Key? key, required this.data, required this.id }) : super(key: key);

  @override
  State<DeleteHospital> createState() => _EditHospitalState();
}

class _EditHospitalState extends State<DeleteHospital> {

  String field1 = "";
  String field2 = "";
  String field3 = "";
  String field4 = "";
  String City = "";
  void initState() {
    super.initState();
    field1 = widget.data['field1'];
    field2 = widget.data['field2'];
    field3 = widget.data['field2'];
    City= widget.data['City'];
    field4 = widget.data['noofbeds'].toString();
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
          "Delete Hospitals",
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
                controller: TextEditingController()..text = widget.data['field1'],
                onChanged: (value){
                  field1 = value;
                },
              ),
              TextField(
                controller: TextEditingController()..text = widget.data['field2'],
                onChanged: (value){
                  field2 = value;
                },
              ),
              TextField(
                controller: TextEditingController()..text = widget.data['field3'],
                onChanged: (value){
                  field3 = value;
                },
              ),
              TextField(
                controller: TextEditingController()..text = widget.data['City'],
                onChanged: (value){
                  City = value;
                },
              ),
              TextField(
                controller: TextEditingController()..text = widget.data['noofbeds'].toString(),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                onChanged: (value){
                  field4 = value;
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(onPressed: () async {
                await FirebaseFirestore.instance.collection("test").doc(widget.id).delete();
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