import 'package:clinic/pages/user/commit_appointment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:select_form_field/select_form_field.dart';
class BookAppointmentsPage extends StatefulWidget {
  const BookAppointmentsPage({ Key? key }) : super(key: key);

  @override
  State<BookAppointmentsPage> createState() => _BookAppointmentsPageState();
}

class _BookAppointmentsPageState extends State<BookAppointmentsPage> {
  TextEditingController _searchcontroller = TextEditingController();
  var selectedValue="Cities";
  var select = "select";
  List<String> items1 = [
    "Cities"
  ];
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
          "Book Appointments",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('appointment').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            // handle error
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            // return progress indicator widget
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          List SearchList = [];
          for (var v in snapshot.data.docs) {
            if (_searchcontroller.text.trim() == "") {
              SearchList = snapshot.data.docs;
              break;
            } else {
              if (v.data()['doctor name'].contains(_searchcontroller.text.trim())) {
                SearchList.add(v);
              }
            }
          }

          for (var v in snapshot.data.docs) {
            if (!items1.contains(v.get("City"))) {
              items1.add(v.get("City"));
            }
          }print(items1);

          if (selectedValue != "Cities") {
            List Temp = [];
            Fluttertoast.showToast(
                msg: "Record found");
            for (var c in SearchList) {
              if (c.get("City") == selectedValue) {
                Temp.add(c);
              }
            }
            SearchList = Temp;

          }

          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                  ),
                ),

                DropdownFormField(
                  onEmptyActionPressed: () async {},
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      labelText: "City"),
                  onSaved: (dynamic str) {
                  },
                  onChanged: (dynamic str) {
                    setState(() {
                      selectedValue=str;
                    });
                  },
                  validator: (dynamic str) {},
                  displayItemFn: (dynamic item) => Text(
                    item?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                  findFn: (dynamic str) async => items1,
                  filterFn: (dynamic item, str) =>
                  item.toLowerCase().indexOf(str.toLowerCase()) >= 0,
                  dropdownItemFn: (dynamic item, position, focused,
                      dynamic lastSelectedItem, onTap) =>
                      ListTile(
                        title: Text(item),
                        tileColor:
                        focused ? Color.fromARGB(20, 0, 0, 0) : Colors.transparent,
                        onTap: onTap,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: SearchList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot Hospital = SearchList[index];
                      return Card(
                        color: Colors.lightBlue.shade200,
                        clipBehavior: Clip.hardEdge,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          leading: Icon(
                            Icons.local_hospital,
                            color: Colors.green,
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    new Text(
                                      'Doctor name : ',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 20),
                                    ),
                                    new Text(
                                      Hospital['doctor name'],
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 18),
                                    ),
                                    Icon(
                                      Icons.local_hospital_outlined,
                                      color: Colors.blueAccent,
                                    )
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    new Text(
                                      'Hospital description : ',
                                      style: TextStyle(
                                          color: Colors.blueGrey, fontSize: 20),
                                    ),
                                    new Text(
                                      Hospital['hospital description'],
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: Colors.blueGrey, fontSize: 18),
                                    ),
                                    Icon(
                                      Icons.description_outlined,
                                      color: Colors.blueGrey,
                                    )
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    new Text(
                                      'Hospital location : ',
                                      style: TextStyle(
                                          color: Colors.brown, fontSize: 20),
                                    ),
                                    new Text(
                                      Hospital['hospital location'],
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: Colors.brown, fontSize: 18),
                                    ),
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.brown,
                                    )
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    new Text(
                                      'City : ',
                                      style: TextStyle(
                                          color: Colors.purple, fontSize: 20),
                                    ),
                                    new Text(
                                      Hospital['City'],
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: Colors.purple, fontSize: 18),
                                    ),
                                    Icon(
                                      Icons.location_city,
                                      color: Colors.purple,
                                    )
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    new Text(
                                      'Time : ',
                                      style: TextStyle(
                                          color: Colors.purple, fontSize: 20),
                                    ),
                                    new Text(
                                      Hospital['time'],
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: Colors.purple, fontSize: 18),
                                    ),
                                    Icon(
                                      Icons.timer,
                                      color: Colors.purple,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return CommitAppointmentPage(
                                            data: Hospital, id: Hospital.id);
                                      },
                                    ),
                                  );
                                },
                                child: new Text(
                                  "Book",
                                  style: TextStyle(
                                      color: Colors.deepPurple, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}