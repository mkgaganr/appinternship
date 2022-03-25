import 'package:clinic/pages/Dashboard/dashboard_page.dart';
import 'package:clinic/pages/intermediate/intermediate_page.dart';
import 'package:clinic/pages/welcome/welcome_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckLoginPage extends StatefulWidget {
  const CheckLoginPage({ Key? key }) : super(key: key);

  @override
  State<CheckLoginPage> createState() => _CheckLoginPageState();
}

class _CheckLoginPageState extends State<CheckLoginPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
         if(snapshot.hasError) {
          return const Text('Error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
        // return progress indicator widget
          return const Center(child: CircularProgressIndicator());
        }
        if(snapshot.data == null)
          return WelcomePage();
        else
        {
          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('admin').snapshots(),
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
            Map<String,dynamic> userDataMap= {

            };
            int flag = 0;
            if(snapshot.hasData)
            {
              if(snapshot.data.docs.length > 0){       
                
                for(int i=0;i<snapshot.data.docs.length;i++)
                {
                  userDataMap = snapshot.data.docs[i].data();
                  if(userDataMap['email'] == FirebaseAuth.instance.currentUser!.email)
                  {
                    flag = 1;   
                    //print(userDataMap['email']);
                    break;             
                  }
                }
                if(flag == 1)
                {
                 // print(userDataMap['email']);
                  return Intermediate();
                }
                else 
                {
                  return DashboardPage();
                }
              }
                
            }
          return SizedBox(height: 0.0,);
          } 
          );
          
        }
        /*if(FirebaseAuth.instance.currentUser!.email)
          return DashboardPage();*/
        return Scaffold(
       
        );
      }
    );
  }
}