import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_demo_app/pages/Dashboard/dashboard_page.dart';
import 'package:my_demo_app/widgets/my_button.dart';

class Myprofile extends StatelessWidget
{

  
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
   /* return  TextFormField(
              decoration: InputDecoration(
                filled: true,
                hintText: hintText,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
        ), 
        elevation: 0.0,
        title: Text(
          "My Profile",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Colors.black),),
        ],
      ),
      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                      backgroundImage: AssetImage("images/non_profile.jpg"),
                      radius: 50,                    
                  ),
                ],
              ),
              textFromField("Abhaya"),
              textFromField("abhayademo@gmail.com"),
            ],
          ),
        ),
        Expanded(
            child: Container(),
            ),
        ],
      ),
    ),
    )
    );
  }
}