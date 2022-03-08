import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hmsf_intern/pages/Dashboard/dashboard_page.dart';

class Myprofile extends StatelessWidget
{
  @override
  Widget lisTile({IconData icon,String title})
  {
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward),
        )
      ],
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "My Profile",
          style: TextStyle(
            fontSize: 18,
            color: Colors.deepPurple,
          ),
        ),
      ),
      drawer: DashboardPage(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                color: Colors.blueGrey,
              ),
              Container(
                height: 548,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )
                ),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 250,
                          height: 80,
                          padding: EdgeInsets.only(left: 67),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "M K Gagan Roshan",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Text("gagan.cs18@bmsce.ac.in"),
                                    ],
                                  ),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.yellow,
                                    child: CircleAvatar(
                                      radius: 12,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],

                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40,left: 30),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
