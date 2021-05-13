import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:road_degradation_app/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:road_degradation_app/signup.dart';

import 'ls_viewpotholelst_Screen.dart';
import 'main.dart';

class Login extends StatefulWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override

  _Login createState() => _Login();
}

class _Login extends State<Login>{
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
  void initState() {initializeFlutterFire();

  super.initState();
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
                                  child:Text("Login!",style: TextStyle(color: Colors.black87, fontStyle:FontStyle.italic, fontSize:30, fontWeight: FontWeight.bold),),

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
                                        controller:widget.emailController,
                                        onChanged: (value) {
                                          email = value; //get the value entered by user.
                                        },
                                        decoration:InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email or Phone Number",

                                            hintStyle: TextStyle(color: Colors.grey[400])

                                        ),
                                      ),
                                    ),

                                  ]

                              ),

                            ),
                            SizedBox(height:20.0,),
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
                                        controller:widget.passwordController,
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


                            SizedBox(height:30,),


                            Material(
                                elevation:5,
                                color:Colors.purple,
                                borderRadius: BorderRadius.circular(32.0),
                                child:MaterialButton(
                                  onPressed: () async{
                                    try{

                                      final newUser = await _auth.signInWithEmailAndPassword(
                                          email: email, password:password);
                                      print(newUser.toString());
                                      if (newUser != null) {
                                        DatabaseReference lansur = FirebaseDatabase.instance.reference().child(
                                            "landsur");
                                        DatabaseReference users = FirebaseDatabase.instance.reference().child(
                                            "users");

                                        lansur.once().then((DataSnapshot snap) {
                                          var lan_keys = snap.value.keys;
                                          // var data = snap.value;
                                          if(lan_keys!=null){
                                            if(lan_keys.contains(newUser.user.uid)){
                                              navg_lansur(newUser.user.uid);

                                            }
                                          }

                                        });
                                        users.once().then((DataSnapshot snap) {
                                         var  user_keys = snap.value.keys;
                                          // var data = snap.value;
                                          if(user_keys.contains(newUser.user.uid)){
                                            navg_user(newUser.user.uid);

                                          }
                                        });

                                        Fluttertoast.showToast(
                                            msg: "Login Successful",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,

                                            backgroundColor: Colors.blueAccent,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        sleep(Duration(seconds:2));





                                      }
                                    } catch (e) {
                                      Fluttertoast.showToast(
                                          msg: "Incorrect email address or Password",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,

                                          backgroundColor: Colors.blueAccent,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      print("EEEEEERRRRRRRROOROOOORRRRR")
;                                      print(e);

                                    }

                                  },
                                  minWidth: 200.0,
                                  height: 40.0,
                                  child: Text(
                                    "Login",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                                  ),


                                )

                            ),
                            GestureDetector(
                                onTap:(){


                                },
                                child:Container(
                                  child:Text("Forgot Password?", style:TextStyle(color:Colors.grey),),



                                )

                            ),
                            GestureDetector(
                                onTap:(){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder:(context)=>Signup())
                                  );


                                },
                                child:Container(
                                  padding: EdgeInsets.all(20.0),
                                  child:Text("New User? Click Here!", style:TextStyle(color:Colors.grey),),



                                )

                            ),
                          ]
                      )
                  )

                ]
            )

        )


    );

  }


  navg_user(var newuser) async{
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
          new Myhomepage(newuser)
      ),
    );
  }

  navg_lansur(var newuser) async{
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
          new Ls_ViewList_Screen(newuser)
      ),
    );
  }

}