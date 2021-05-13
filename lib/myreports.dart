

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class MyReportsScreen extends StatefulWidget {
  @override
  final potholedatabaseref = FirebaseDatabase.instance.reference().child("potholes");
  final usersedatabaseref = FirebaseDatabase.instance.reference().child("users");
  MyReportsScreen({Key key}) : super(key: key);

  _MyReportsScreen createState() => _MyReportsScreen();
}


class _MyReportsScreen extends State<MyReportsScreen> {
  @override



  Container MyPothole(String imageVal, String heading, String subHeading){

   return Container(
      width:160.0,
      child: Card(
        child: Wrap(
          children:<Widget> [
            Image.network(imageVal),
            ListTile(
              title: Text(heading),
              subtitle: Text(subHeading),
            ) ,
            new RaisedButton(onPressed: (){
                   getData();

            }    ,

             child: new Text('Submit Report'),
              elevation: 5),
          ],
        ),
      ),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black
      ,
      body: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 300,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              
            MyPothole("https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60", "heading1", "subHeading1"),
              MyPothole("https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60", "heading1", "subHeading1"),
              MyPothole("https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60", "heading1", "subHeading1"),
                    
            ],
          ),



        )

        );

  }

  void getData(){
    var userspotholes;
    widget.usersedatabaseref.child("6eonRKtMehWONqvNtq8FmsdiIwf1").once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
      userspotholes=snapshot.value;

    });

    Map<dynamic, dynamic> upotholes =userspotholes;
List<String> potholeskey;

//    print(fridgesDs.runtimeType);
    upotholes.forEach((key, value) {
      if (value) {
        potholeskey.add(key);
      }
    });
      print(potholeskey);
    // widget.potholedatabaseref.child().once().then((DataSnapshot snapshot) {
    //   print('Data : ${snapshot.value}');
    // });
  }
}
