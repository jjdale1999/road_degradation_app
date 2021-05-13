import 'dart:async';
import 'dart:io';
import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart';

import 'package:road_degradation_app/main.dart';

import 'login.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}


class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => Login()
            )
        )
    );
  }


  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black
    ,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Lottie.asset('assets/splash_screen.json',height:700),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'DETECTARC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      'Create by: Nexu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
