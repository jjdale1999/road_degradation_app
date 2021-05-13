

import 'dart:async';
// import 'dart:html';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:road_degradation_app/login.dart';
import 'package:road_degradation_app/potholeinfo.dart';

import 'ls_verifyscreen.dart';


class Ls_ViewList_Screen extends StatefulWidget {
  @override
  var user;
  Ls_ViewList_Screen(this.user, {Key key}) : super(key: key);
  _Ls_ViewList_Screen createState() => _Ls_ViewList_Screen();
}


class _Ls_ViewList_Screen extends State<Ls_ViewList_Screen> {
  @override
  List<Pothole> potholelst =[];

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }


  void initState() {
    initializeFlutterFire();
    super.initState();

    // _onNoteAddedSubscription = notesReference.onChildAdded.listen(_onNoteAdded);
    DatabaseReference idkref = FirebaseDatabase.instance.reference().child(
        "landsur").child(widget.user);
    idkref.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var dataland = snap.value;


     potholelst.clear();



      for(var individualkey in keys){

      DatabaseReference idkref = FirebaseDatabase.instance.reference().child(
            "potholes").child(individualkey);
        idkref.once().then((DataSnapshot snap) {
          // var keys = snap.value.keys;
          var data = snap.value;
          print(data);
         // for(var individualkey in keys){

        Pothole pothole = new Pothole(
          data['image'],
          data['latitude'].toString(),
          data['longitude'].toString(),
            individualkey,
            data['address'],
            data['severity']

        );
          print(pothole);
          potholelst.add(pothole);
          print(potholelst);

        // }

        setState(() {
          print('length : $potholelst.length');
        });
      });

      }
  });
  }



  Widget build(BuildContext context) {
    return Scaffold(


        backgroundColor: Colors.white
        ,
        body: new Container(
            width :MediaQuery. of(context). size. width,
            height : MediaQuery. of(context). size. height,
          child: potholelst.length==0 ? new Text("No data avalibale") : new ListView.builder(
              itemCount: potholelst.length,
              itemBuilder: (_,index){
                return PostUI(potholelst[index].image,potholelst[index].latitude,potholelst[index].longitude,potholelst[index].potholekey,potholelst[index].address,potholelst[index].predict);

              }

          )
        )





    );

  }

  Widget PostUI(String image,String latitude,String longitiude, var potholekey,var location,  var predict){
    return  new Card(
      elevation: 10.0,
      margin:EdgeInsets.all(15.0),
      child: new Container(
          padding: new EdgeInsets.all(14.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Image.network(image,fit:BoxFit.cover),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    new Row(
                      children: [
                        Icon(Icons.location_on),
                        new Text(
                          latitude,
                          style:Theme.of(context).textTheme.subtitle,
                          textAlign: TextAlign.center,
                        ),
                        new Text(
                          longitiude,
                          style:Theme.of(context).textTheme.subtitle,
                          textAlign: TextAlign.center,
                        ),
                      ],

                    ),


                  ],
                ),
                Align(
                  alignment: Alignment(1.8, 1.0),
                  heightFactor: 0.5,
                  child: FloatingActionButton(
                    onPressed: () => navg(widget.user,potholekey,location,double.parse(latitude),double.parse(longitiude), predict,image),
                    child: Text("verify"),
                  ),
                )


              ],
            ),



          ],

        ),

      ),

    );
  }



  navg( var user,String potholekey,String location,double latitude,double longitiude, String predict,String image) async{
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
          new Ls_VerifyScreen( user,potholekey,location,latitude,longitiude, predict,image)
      ),
    );
  }


  @override
  void dispose() {
    // Never called
    print("Disposing first route");
    super.dispose();
  }
}
