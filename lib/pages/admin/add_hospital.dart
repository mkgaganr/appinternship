import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Addhospital extends StatefulWidget
{
  @override
  _AddhospitalState createState() =>_AddhospitalState();
}

class _AddhospitalState extends State<Addhospital>
{
  TextEditingController hospitalname=TextEditingController();
  TextEditingController hospitallocation=TextEditingController();
  TextEditingController noofbeds=TextEditingController();
  final firebase =Firestore.instance;
  add() async{
    try{
       await firebase.collection("hospitals")
          .doc.set({
        "hospitalname": hospitalname.text,
        "hospitallocation":hospitallocation.text,
        "noofbeds":noofbeds.value
      });
    } catch(e){
      print(e);
    }
  }
  update() async{
    try{} catch(e){
      print(e);
    }
  }
  delete() async{
    try{} catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add hospitals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: hospitalname,
              decoration: InputDecoration(
                labelText: "Hospital name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: hospitallocation,
              decoration: InputDecoration(
                  labelText: "Hospital location",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: noofbeds,
              decoration: InputDecoration(
                  labelText: "no of beds",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: (){
                      add();
                      hospitalname.clear();
                      hospitallocation.clear();
                      noofbeds.clear();
                    },
                    child: Text("Add")),
                ElevatedButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.amber),
                    onPressed: (){
                      update();
                      hospitalname.clear();
                      hospitallocation.clear();
                      noofbeds.clear();
                    },
                    child: Text("Update")),
                ElevatedButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: (){
                      delete();
                      hospitalname.clear();
                      hospitallocation.clear();
                      noofbeds.clear();
                    },
                    child: Text("Delete")),
              ],
            )
          ],
        ),
      ),
    );
  }
}