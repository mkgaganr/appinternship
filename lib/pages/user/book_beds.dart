import 'package:clinic/pages/user/commit_booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookBedsPage extends StatefulWidget {
  const BookBedsPage({ Key? key }) : super(key: key);

  @override
  State<BookBedsPage> createState() => _BookBedsPageState();
}

class _BookBedsPageState extends State<BookBedsPage> {
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
        builder: (context,AsyncSnapshot snapshot){
          if (snapshot.hasError) {
            // handle error
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            // return progress indicator widget
            return const Center(child: CircularProgressIndicator());
          }
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              DocumentSnapshot Hospital = snapshot.data!.docs[index];
              return Card(
                color: Colors.lightBlue.shade200,
                clipBehavior: Clip.hardEdge,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(5),
                  ),
                  leading: Icon(Icons.local_hospital,color: Colors.green,),
                  title: Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  new Text('Hospital name : ',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 20
                                  ),),
                                  new Text(Hospital['field1'], overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 18
                                  ),),
                                  Icon(Icons.local_hospital_outlined,
                                  color: Colors.blueAccent,)
                                ],
                              ),
                            ),

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                new Text('Hospital description : ',
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 20
                                  ),),
                                new Text(Hospital['field2'], overflow: TextOverflow.clip,
                                 style: TextStyle(
                                   color: Colors.blueGrey,
                                   fontSize: 18
                                 ),),
                                Icon(Icons.description_outlined,
                                  color: Colors.blueGrey,)
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                new Text('Hospital location : ',
                                  style: TextStyle(
                                      color: Colors.brown,
                                      fontSize: 20
                                  ),),
                                new Text(Hospital['field3'], overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: Colors.brown,
                                      fontSize: 18
                                  ),),
                                Icon(Icons.location_on_outlined,
                                  color: Colors.brown,)
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                new Text('No of beds available : ',
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 20
                                  ),),
                                new Text(Hospital['noofbeds'].toString(), overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 18
                                  ),),
                                Icon(Icons.bed_rounded,
                                  color: Colors.purple,)
                              ],
                            ),
                          ),






                          SizedBox(height: 10),
                          ElevatedButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                              return CommitBookingPage(data: Hospital, id: Hospital.id);
                        },
                        ),
                        );
                          }, 
                          child: new Text("Book",style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 16
                          ),),
                          ),
                        ],

                      ),
                    ),
                  ) ,
                ),
              );
            },
          );
        },
      ),
    );
  }
}