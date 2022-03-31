import 'package:clinic/pages/admin/appointment_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditAppointment extends StatefulWidget {
  final DocumentSnapshot data;
  final String id;
  const EditAppointment({ Key? key,required this.data, required this.id }) : super(key: key);

  @override
  State<EditAppointment> createState() => _EditAppointmentState();
}

class _EditAppointmentState extends State<EditAppointment> {
  String field1 = "";
  String field2 = "";
  String field3 = "";
  String field4 = "";
  String time = "";
  void initState() {
    super.initState();
    field1 = widget.data['doctor name'];
    field2 = widget.data['hospital description'];
    field3 = widget.data['hospital location'];
    time= widget.data['time'];
    field4 = widget.data['City'];
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
          "Update Appointments",
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
                  controller: TextEditingController()..text = widget.data['doctor name'],
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
                  controller: TextEditingController()..text = widget.data['hospital description'],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "hospital description",
                  ),
                  onChanged: (value) {
                    field2 = value;
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
                  controller: TextEditingController()..text = widget.data['hospital location'],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Hospital location",
                  ),
                  onChanged: (value) {
                    field3 = value;
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
                  controller: TextEditingController()..text = widget.data['City'],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "City",
                  ),
                  onChanged: (value) {
                    field4=value;
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
                  controller: TextEditingController()..text = widget.data['time'],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Time",
                  ),
                  onChanged: (value) {
                    time = value;
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
                Map <String,dynamic> data1={"doctor name" :field1,"hospital description":field2,"hospital location":field3,"time":time,"City":field4};
                await FirebaseFirestore.instance.collection("appointment").doc(widget.id).update(data1);
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