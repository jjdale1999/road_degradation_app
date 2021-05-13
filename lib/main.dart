import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:road_degradation_app/myreports.dart';
import 'package:road_degradation_app/splashscreen.dart';
import 'package:road_degradation_app/viewreport.dart';
import 'package:road_degradation_app/homepage.dart';

import 'login.dart';
import 'ls_viewpotholelst_Screen.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,

    home: SplashScreen(),
  ));
}

class Myhomepage extends StatefulWidget {
  @override
  var user;
  Myhomepage(this.user, {Key key}) : super(key: key);


  HomePage createState() => HomePage();
}


class MyApp extends StatefulWidget {
  @override
  final String location;
  final String predict;
  final File image;
  final potholedatabaseref = FirebaseDatabase.instance.reference().child("potholes");
  final usersedatabaseref = FirebaseDatabase.instance.reference().child("users");

  final double longitiude;
  final double latitude;
  var user;
  MyApp({Key key, this.user,this.location,this.latitude,this.longitiude, this.predict,this.image}) : super(key: key);

  ViewReport createState() => ViewReport();
}
