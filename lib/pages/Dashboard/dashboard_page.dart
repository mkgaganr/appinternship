import 'package:clinic/pages/Dashboard/contact_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:clinic/pages/myprofile/myprofile.dart';

import '../user/book_appointments.dart';
import '../user/book_beds.dart';


class DashboardPage extends StatelessWidget {
  get onPressed => null;

  Widget textFromField(String hintText){
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.lightBlueAccent[100],
      ),
      child: ListTile(
        leading: Text(hintText),
      ),
      );
  }

  Widget listTile({IconData? icon,String? title,void Function()? onTap}){
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 45,
      ),
      title: Text(title!,style: TextStyle(color: Colors.black54),),
    );
  }


  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Color(0xff42A5F5),
          child: ListView(
            children: [
              DrawerHeader(
                child: Row(
                  children: [
                    
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                            child: Center(child: Text('Welcome User',
                                              style: TextStyle(fontSize: 20.0, fontFamily: 'sans-serif',color: Colors.black.withOpacity(0.5)),
                                              )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                         
                          
                        ],
                      ),
                    )
                  ],
                  
                ),
                
              ),
              listTile(
                icon: Icons.home_outlined,
                title: "Home",
              ),
              listTile(
                icon: Icons.account_box,
                title: "My Profile",
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Myprofile(),),);
                },
              ),
              
              
              listTile(
                icon: Icons.contact_support,
                title: "Contact us",
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Contact()));
                }
              ),
              listTile(
                icon: Icons.logout,
                title: "log out",
                onTap: (){
                  FirebaseAuth.instance.signOut().whenComplete(() {
                    while (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  });
                },
              ),

            ],

          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        title: Text('Home',
          style: TextStyle(
              color: Colors.black54,
              fontSize: 17
          ),
        ),
        actions: [
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.white30,
                child: Icon(Icons.local_hospital,size: 17,color: Colors.black,)
            ),
          ),
        ],
        backgroundColor: Color(0xff42A5F5),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('https://wallpaperaccess.com/full/1282794.jpg')
                  ),

                  color: Color.fromARGB(242, 204, 255, 204),
                  borderRadius: BorderRadiusDirectional.circular(10)
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              color: Colors.blue,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookBedsPage(),),);
                },
                splashColor: Colors.green,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      Icon(Icons.local_hospital_outlined,size:70.0,),
                      Text('Book Bed',style: new TextStyle(fontSize: 20.0),),

                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              color: Colors.blue,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookAppointmentsPage(),),);
                },
                splashColor: Colors.green,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      Icon(Icons.description_outlined,size:70.0,),
                      Text('Book appointment',style: new TextStyle(fontSize: 20.0),)
                    ],
                  ),
                ),
              ),
            ),
              ],
            )
        ),
      ),
    );
  }
}