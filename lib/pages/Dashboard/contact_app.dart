import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact us'
        ),
      ),
      body:  Container(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 60.0,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        'Contact for any help and queries',
                        textAlign: TextAlign.justify,
                        style: TextStyle(

                          fontFamily: 'SourceSansPro',
                          color: Colors.black45,
                          fontSize: 35,
                          
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0,),
                  Card(
                    color: Colors.blue[100],
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.mail_sharp,
                        color: Colors.red[900],
                      ),
                      title: Text(
                        'badlavgroup2100@gmail.com',
                        style:
                        TextStyle(fontFamily: 'BalooBhai', fontSize: 18.0),
                      ),
                      onTap: () => launch("mailto: badlavgroup2100@gmail.com"),
                    ),
                  ),
                  Card(
                    color: Colors.green[100],
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.blueAccent[900],
                      ),
                      title: Text(
                        '+91 9458581922',
                        style:
                        TextStyle(fontFamily: 'BalooBhai', fontSize: 18.0),
                      ),
                      onTap: () => launch("tel:+91 9458581922"),
                    ),
                  ),
                ]
            )
        ),
      ),
    );

  }
}