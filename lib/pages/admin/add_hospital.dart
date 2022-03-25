import 'package:clinic/pages/admin/admin.dart';
import 'package:clinic/pages/admin/update_hospital.dart';
import 'package:clinic/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Addhospital extends StatefulWidget
{
  @override
  State<Addhospital> createState() => _AddhospitalState();
}

class _AddhospitalState extends State<Addhospital> {
  bool visibility = true;
  String field1 = "";
  String field2 = "";
  String field3 = "";
  String field4 = "";
  String noofbeds="";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0.0,
        title: Text(
          "Add Hospital",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                


                const SizedBox(
                  height: 20,
                ),

                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
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
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "hospital location",
                            ),
                            onChanged: (value) {
                              field3 = value;
                            },
                            validator: (value) {
                              value ??= "";
                              if (value.trim() == "") {
                                return "Hospital location required";
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "no of beds",
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                            onChanged: (value) {
                              noofbeds =value;
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
                      ],
                    )),

                MyButton(
                        onPressed: (){
                        if(_formKey.currentState!.validate()){
                       Map <String,dynamic> data=
                        {"field1" :field1,
                        "field2":field2,
                        "field3":field3,"noofbeds":int.parse(noofbeds)};
                     FirebaseFirestore.instance.collection("test").add(data);
                     Fluttertoast.showToast(msg: "Added Successfully");
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Admin()));
                     }
                     }, text: "add"
                ), 
                SizedBox(
                  height: 10,
                ),
                MyButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HospitalList()));}, text: "Posted Hospitals"), // MyButton
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}