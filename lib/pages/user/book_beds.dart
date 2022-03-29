import 'package:clinic/pages/user/commit_booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookBedsPage extends StatefulWidget {
  const BookBedsPage({Key? key}) : super(key: key);

  @override
  State<BookBedsPage> createState() => _BookBedsPageState();
}

class _BookBedsPageState extends State<BookBedsPage> {
  TextEditingController _searchcontroller = TextEditingController();
  var selectedValue="select";
  var select = "select";
  List<String> items = [
    "select"
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
          "Book Hospitals",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('test').snapshots(),
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
              if (v.data()['field1'].contains(_searchcontroller.text.trim())) {
                SearchList.add(v);
              }
            }
          }

          for (var v in snapshot.data.docs) {
            if (!items.contains(v.get("field3"))) {
              items.add(v.get("field3"));
            }
          }print(items);

          if (selectedValue != "select") {
            List Temp = [];
            for (var c in SearchList) {
              if (c.get("field3") == selectedValue) {
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
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _searchcontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Search by Hospital name",
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: Text('Search')),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: DropdownButtonHideUnderline(

                    child: Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: DropdownButton2(

                        style: TextStyle(
                            color: Colors.blue
                        ),
                       dropdownDecoration: BoxDecoration(
                         color: Colors.purple,
                         border: Border.all(color: Colors.grey,width: 3),
                         borderRadius: BorderRadius.circular(50),
                         boxShadow: <BoxShadow>[
                           BoxShadow(
                             color: Color.fromRGBO(0, 0, 0, 0.57),
                             blurRadius: 5
                           )
                         ]
                       ),

                        hint: Text(
                          'Select Item',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: items
                            .map((item) =>DropdownMenuItem<String>(
                          value:item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        )).toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                      ),
                    ),
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
                                          'Hospital name : ',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 20),
                                        ),
                                        new Text(
                                          Hospital['field1'],
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
                                          Hospital['field2'],
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
                                          Hospital['field3'],
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
                                          'No of beds available : ',
                                          style: TextStyle(
                                              color: Colors.purple, fontSize: 20),
                                        ),
                                        new Text(
                                          Hospital['noofbeds'].toString(),
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color: Colors.purple, fontSize: 18),
                                        ),
                                        Icon(
                                          Icons.bed_rounded,
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
                                            return CommitBookingPage(
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