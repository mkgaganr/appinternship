import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Addhospital extends StatelessWidget
{
  TextEditingController sampledata1 = new TextEditingController();
  TextEditingController sampledata2 = new TextEditingController();
  TextEditingController sampledata3 = new TextEditingController();
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add hospitals'
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: sampledata1,
                decoration: InputDecoration(
                  hintText: "hospital name"
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: sampledata2,
                decoration: InputDecoration(
                  hintText: "hospital location"
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: sampledata3,
                decoration: InputDecoration(
                    hintText: "hospital description"
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(onPressed: (){
                Map <String,dynamic> data={"field1" :sampledata1.text,"field2":sampledata2.text,"field3":sampledata3.text};
                Firestore.instance.collection("test").add(data);
              }, child:Text("submit"),color: Colors.blueAccent, )
            ],
          ),
        ),
      ),
    );
  }
}
