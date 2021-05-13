import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:road_degradation_app/homepage.dart';
import 'package:road_degradation_app/main.dart';

import 'login.dart';
import 'dart:io';

class Signup extends StatefulWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _Signup createState() => _Signup();
}
class _Signup extends State<Signup>{
  String email,password;
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
  @override
  Widget build(BuildContext context){
    final _auth = FirebaseAuth.instance;
    return Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor:Colors.white,
        body:Container(
            child:Column(

                children: <Widget>[
                  Container(
                    height: 350,
                    decoration:BoxDecoration(
                        image:DecorationImage(

                            image:AssetImage("assets/bgimage.jpg"),
                            fit:BoxFit.fill

                        )
                    ),
                    child:Stack(
                      children:<Widget>[
                        Positioned(
                          right:30,
                          width:100,
                          height:200,
                          child:Container(
                            decoration:BoxDecoration(
                                image:DecorationImage(
                                    image:AssetImage('assets/walk.png')
                                )
                            ),
                          ),
                        ),
                        Positioned(
                            child:Container(
                                margin: EdgeInsets.only(top:50),
                                child:Center(


                                )

                            )

                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(30.0),
                      child:Column(
                          children:<Widget>[
                            Container(
                              padding: EdgeInsets.all(0.0),
                              decoration:BoxDecoration(
                                  color:Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow:[
                                    BoxShadow(
                                        color: Color.fromRGBO(143,148,251,1),
                                        blurRadius: 20.0,
                                        offset: Offset(0,10)
                                    )
                                  ]

                              ),
                              child:Column(
                                  children:<Widget>[
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border(bottom:BorderSide(color: Colors.grey[100]))

                                      ),
                                      child:TextField(
                                        onChanged: (value) {
                                          email = value; //get the value entered by user.
                                        },
                                        decoration:InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email",
                                            hintStyle: TextStyle(color: Colors.grey[400])

                                        ),
                                      ),
                                    ),

                                  ]

                              ),

                            ),
                            SizedBox(height:10.0,),
                            Container(
                              padding: EdgeInsets.all(0.0),
                              decoration:BoxDecoration(
                                  color:Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow:[
                                    BoxShadow(
                                        color: Color.fromRGBO(143,148,251,1),
                                        blurRadius: 20.0,
                                        offset: Offset(0,10)
                                    )
                                  ]

                              ),
                              child:Column(
                                  children:<Widget>[
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border(bottom:BorderSide(color: Colors.grey[100]))

                                      ),
                                      child:TextField(
                                        onChanged: (value) {
                                          password = value; //get the value entered by user.
                                        },
                                        decoration:InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            hintStyle: TextStyle(color: Colors.grey[400])

                                        ),
                                      ),
                                    ),

                                  ]

                              ),

                            ),
                            SizedBox(height:10.0,),
                            Container(
                              padding: EdgeInsets.all(0.0),
                              decoration:BoxDecoration(
                                  color:Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow:[
                                    BoxShadow(
                                        color: Color.fromRGBO(143,148,251,1),
                                        blurRadius: 20.0,
                                        offset: Offset(0,10)
                                    )
                                  ]

                              ),
                              child:Column(
                                  children:<Widget>[
                                    Container(
                                      padding: EdgeInsets.all(0.0),
                                      decoration: BoxDecoration(
                                          border: Border(bottom:BorderSide(color: Colors.grey[100]))

                                      ),
                                      child:TextField(

                                        decoration:InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Phone Number",
                                            hintStyle: TextStyle(color: Colors.grey[400])

                                        ),
                                      ),
                                    ),

                                  ]

                              ),

                            ),


                            SizedBox(height:70,),
                            Material(
                              elevation:5,
                              color:Colors.pink,
                              borderRadius: BorderRadius.circular(16.0),
                              child: MaterialButton(
                                color: Colors.pink,
                                disabledColor: Colors.purple,
                                onPressed:() async{
                                  print("Do you even press?");
                                  try {
                                    print("You get into the try block");
                                    final newuser =
                                    await _auth
                                        .createUserWithEmailAndPassword(
                                        email: email, password: password);
                                    print("You get this far");
                                    if (newuser != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Myhomepage(newuser)),
                                      );
                                    }

                                    Fluttertoast.showToast(
                                        msg: "Created Successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.pink,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }catch(e) {

                                    Fluttertoast.showToast(
                                        msg: "We didnt get to create it fam",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,

                                        backgroundColor: Colors.blueAccent,
                                        textColor: Colors.white,
                                        fontSize: 16.0);

                                  }

                                  sleep(Duration(seconds:2));

                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder:(context)=>Login())
                                  );

                                },

                                child: Text("Sign Up!",style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold),),
                              ),
                            ),

                          ]
                      )
                  )

                ]
            )

        )


    );

  }
}