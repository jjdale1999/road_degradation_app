

// import 'dart:html';
import 'dart:io';


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

import 'ls_viewpotholelst_Screen.dart';
import 'main.dart';


class Ls_VerifyScreen extends StatefulWidget {
  @override
  @override
  final String location;
  final String predict;
  final String potholekey;
  final String image;
  final databaseReference = FirebaseDatabase.instance.reference().child("potholes");
  final double longitiude;
  final double latitude;
  var user;
  Ls_VerifyScreen(this.user,this.potholekey,this.location,this.latitude,this.longitiude, this.predict,this.image,{Key key}) : super(key: key);


  _Ls_VerifyScreen createState() => _Ls_VerifyScreen();
}


class _Ls_VerifyScreen extends State<Ls_VerifyScreen> {
  @override

var sliderValue=1.0;
  Widget build(BuildContext context) {

    Widget titleSection = new Container(
      padding: const EdgeInsets.all(10.0),
        child: new Row(
          children: [
           new Expanded(
               child: new Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   new Text("x1 in colum",style: TextStyle(fontSize: 25.0)),
                   new Text("x2 in colum",style: TextStyle(fontSize: 25.0))

                 ],
               )
           ),
            new Text("Item 2",style: TextStyle(fontSize: 25.0))

          ],
        )
    );
    return Scaffold(

        backgroundColor: Colors.white
        ,
        body: new ListView(
          children: [
            new Image.network(widget.image,
            fit:BoxFit.cover
            ),
            titleSection,
            Container(
              child: Slider(
                min:0.0,
                max:5.0,
                divisions: 5,
                value:sliderValue,
                activeColor: Color(0xffff520d) ,
                inactiveColor: Colors.blueGrey,
                  label: sliderValue.round().toString(),
                onChanged: (newValue){
                   setState(() {
                     sliderValue=newValue;
                   });
                },
              ),
            ),
            Center(
              child: Container(
                child:   Padding(
                  padding: const  EdgeInsets.all(16.0),
                  child: ConfirmationSlider(
                    height:64.0,
                      width:300.0,
                      backgroundColor: Colors.black12,
                       text:"Slide to Verify Pothole",
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:Colors.white70,
                        fontSize: 18.0,
                      ),
                      onConfirmation: () {
                      updateRecord(context);
                      }
                  ),
                )
              ),
            )



          ],
        )

    );

  }


  void updateRecord(BuildContext context){
    print('Slider confirmed!');
    //need to update in database

    widget.databaseReference.child(widget.potholekey).update({
    //   'description': 'J2EE complete Reference'
    // set status to inprogess
    // set slidervalue to severity
      'severity':sliderValue
    });

    Fluttertoast.showToast(
        msg: "Report Updated and Verified",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

    navg(widget.user);
  }

  navg(var user ) async{
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
          new  Ls_ViewList_Screen(user)
      ),
    );
  }
}
