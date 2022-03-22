import 'package:hmsf_intern/pages/Dashboard/dashboard_page.dart';
import 'package:hmsf_intern/pages/admin/Send_Sms.dart';
import 'package:hmsf_intern/pages/admin/admin.dart';
import 'package:hmsf_intern/pages/admin/all_data1.dart';
import 'package:hmsf_intern/pages/admin/update_myprofiel.dart';
import 'package:hmsf_intern/pages/intermediate/intermediate.dart';
import 'package:hmsf_intern/pages/welcome/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clinic Appointments',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:WelcomePage(),
    );
  }
}
