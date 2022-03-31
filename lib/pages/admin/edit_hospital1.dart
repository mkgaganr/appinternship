import 'package:clinic/pages/admin/admin.dart';
import 'package:clinic/pages/admin/update_hospital.dart';
import 'package:clinic/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Edithospital1 extends StatefulWidget
{
  final DocumentSnapshot data;
  final String id;
  const Edithospital1({ Key? key, required this.data, required this.id }) : super(key: key);
  @override
  State<Edithospital1> createState() => _AddhospitalState();
}

class _AddhospitalState extends State<Edithospital1> {
  bool visibility = true;
  void initState() {
    super.initState();
    field1 = widget.data['field1'];
    field2 = widget.data['field2'];
    field3 = widget.data['field2'];
    field4 = widget.data['noofbeds'].toString();
  }
  String field1 = "";
  String field2 = "";
  String field3 = "";
  String field4 = "";
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
          "Update Hospital",
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
                            controller: TextEditingController()..text = widget.data['field3'],
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
                            controller: TextEditingController()..text = widget.data['noofbeds'].toString(),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "no of beds",
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
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
                      ],
                    )),

                MyButton(
                    onPressed: () async {
                        Map <String,dynamic> data1={"field1" :field1,"field2":field2,"field3":field3,"noofbeds":int.parse(field4)};
                        await FirebaseFirestore.instance.collection("test").doc(widget.id).update(data1);
                        Fluttertoast.showToast(msg: "Update Successful");
                        Navigator.of(context).pop();

                    }, text: ""
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}