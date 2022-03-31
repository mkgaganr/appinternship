import 'package:clinic/pages/admin/update_hospital.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditHospital extends StatefulWidget {
  final DocumentSnapshot data;
  final String id;
  const EditHospital({ Key? key, required this.data, required this.id }) : super(key: key);

  @override
  State<EditHospital> createState() => _EditHospitalState();
}

class _EditHospitalState extends State<EditHospital> {
  
  String field1 = "";
  String field2 = "";
  String field3 = "";
  String field4 = "";
  String City = "";
  void initState() {
    super.initState();
    field1 = widget.data['field1'];
    field2 = widget.data['field2'];
    field3 = widget.data['field3'];
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
          "Update Hospitals",
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
              TextFormField(
                  controller: TextEditingController()..text = widget.data['field1'],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Hospital name",
                  ),
                  onChanged: (value) {
                    field1 = value;
                  },
                  validator: (value) {
                    value ??= "";
                    if (value.trim() == "") {
                      return "Hospital name required";
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: TextEditingController()..text = widget.data['City'],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "City",
                  ),
                  onChanged: (value) {
                    City = value;
                  },
                  validator: (value) {
                    value ??= "";
                    if (value.trim() == "") {
                      return "City required";
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: TextEditingController()..text = widget.data['field2'],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Hospital description",
                  ),
                  onChanged: (value) {
                    field2 = value;
                  },
                  validator: (value) {
                    value ??= "";
                    if (value.trim() == "") {
                      return "Hospital description required";
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: TextEditingController()..text = widget.data['field3'].toString(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Hospital Location",
                  ),
                  onChanged: (value) {
                    field3=value;
                  },
                  validator: (value) {
                    value ??= "";
                    if (value.trim() == "") {
                      return "beds required";
                    }
                  }),
              const SizedBox(
                height: 20,
              ),


              TextFormField(
                  controller: TextEditingController()..text = widget.data['noofbeds'].toString(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "No of beds",
                  ),
                  onChanged: (value) {
                    field4 = value;
                  },
                  validator: (value) {
                    value ??= "";
                    if (value.trim() == "") {
                      return "Hospital location required";
                    }
                  }),
              const SizedBox(
                height: 10,
              ),

                SizedBox(
                  height: 10,
                ),
                ElevatedButton(onPressed: () async {
                  Map <String,dynamic> data1={"field1" :field1,"field2":field2,"field3":field3,"noofbeds":int.parse(field4),"City":City};
                    await FirebaseFirestore.instance.collection("test").doc(widget.id).update(data1);
                    Fluttertoast.showToast(msg: "Update Successful");
                    Navigator.of(context).pop();
                },
                 child: Text("Update Data"),
                 ),

            ],
          ),
        ), 
      ),
      
    );
  }
}