import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hmsf_intern/pages/admin/add_hospital.dart';
import 'package:hmsf_intern/pages/myprofile/myprofile.dart';

class DashboardPage extends StatelessWidget {
  Widget listTile({IconData icon,String title,Function onTap}){
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 45,
      ),
      title: Text(title,style: TextStyle(color: Colors.black54),),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Color(0xff42A5F5),
          child: ListView(
            children: [
              DrawerHeader(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white54,
                      radius: 43,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black12,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          Text('Welcome User'),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 30,
                            child: OutlineButton(
                              onPressed: (){},
                              child: Text("Login"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                  width: 2,
                                ),
                              ),
                            ),
                          )
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
                icon: Icons.local_hospital,
                title: "book bed",
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Addhospital(),),);
                },
              ),
              listTile(
                icon: Icons.book_online,
                title: "book appointment",
              ),
              listTile(
                icon: Icons.contact_support,
                title: "Contact us",
              ),
              listTile(
                icon: Icons.logout,
                title: "log out",
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
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.white30,
            child: Icon(Icons.search,size: 17,color: Colors.black,),
          ),
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
      body: Padding(
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
          ],
        ),
      ),
    );
  }
}