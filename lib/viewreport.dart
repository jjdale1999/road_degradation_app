// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:road_degradation_app/main.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fluttertoast/fluttertoast.dart';



class ViewReport extends State<MyApp> {

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
      ),
      body:  Container(
        decoration: new BoxDecoration(color: Colors.black54),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              height: 50,

            ),
            Image.file(widget.image, width:400,height: 250, fit: BoxFit.fitWidth),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.predict,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            )
            ,
            Row(
              children: <Widget>[
                Icon(Icons.location_on),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Location',
                        style: Theme.of(context).textTheme.caption,

                      ),
                      Text("${widget.location}",
                          style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
            new RaisedButton(
              onPressed: () => {

                if(widget.predict == "1 Plain"){
                  showAlert(context)
                }else{
                  uploadImageToFirebase(context)
                }
                // createRecord()
              },
              child: new Text('Submit Report'),
              elevation: 5,
            ),
          ],

        ),
      ),

    );
  }


  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Oh no this seems to not be a pothole'),
          content: Text("Are You Sure Want To Report This Image ?"),
          actions: <Widget>[
            FlatButton(
              child: Text("YES"),
              onPressed: () {
                //Put your code here which you want to execute on Yes button click.
                uploadImageToFirebase(context);
              },
            ),

            FlatButton(
              child: Text("NO"),
              onPressed: () {
                //Put your code here which you want to execute on No button click.
                navg();
              },
            ),

          ],
        );
      },
    );
  }
  void createRecord(){

    widget.potholedatabaseref.push().set({
      'image': "https://firebasestorage.googleapis.com/v0/b/potholedetection-f30ba.appspot.com/o/uploads%2FMyApp.image.path?alt=media&token=75b06ea8-535c-488e-8d9e-89f02040a8e0",
      'address': "Kingston",
      'parish':"",
      'severity': "Pothole or Plain",
      'latitude':22.01,
      'longitude': 18.02,
      'no_of_reports':1,
      'priority':0,
      'arterialPrio':0

    });


    widget.potholedatabaseref.push().set({
      'image': "https://firebasestorage.googleapis.com/v0/b/potholedetection-f30ba.appspot.com/o/uploads%2FMyApp.image.path?alt=media&token=75b06ea8-535c-488e-8d9e-89f02040a8e0",
      'address': "Old Hope Rd",
      'parish':"Kingston",
      'severity': "Pothole",
      'latitude':18.020142,
      'longitude':-76.767916,
      'no_of_reports':1,
      'priority':0,
      'arterialPrio':0

    });


    widget.potholedatabaseref.push().set({
      'image': "",
      'address': "Barbrican Rd",
      'parish':"Kingston",
      'severity': "Pothole",
      'latitude':18.025726,
      'longitude':-76.764901,
      'no_of_reports':0,
      'priority':0,
      'arterialPrio':0

    });





    widget.potholedatabaseref.push().set({
      'image': "https://firebasestorage.googleapis.com/v0/b/potholedetection-f30ba.appspot.com/o/uploads%2FMyApp.image.path?alt=media&token=75b06ea8-535c-488e-8d9e-89f02040a8e0",
      'address': "Albion Ave",
      'parish':"Kingston",
      'severity': "Pothole",
      'latitude':17.992272,
      'longitude':-76.797590,
      'no_of_reports':0,
      'priority':0,
      'arterialPrio':0

    });



    widget.potholedatabaseref.push().set({
      'image': "",
      'address': "Beechwood Ave",
      'parish':"Kingston",
      'severity': "Pothole",
      'latitude':17.996676,
      'longitude':-76.798634,
      'no_of_reports':0,
      'priority':0,
      'arterialPrio':0

    });





    widget.potholedatabaseref.push().set({
      'image': "https://firebasestorage.googleapis.com/v0/b/potholedetection-f30ba.appspot.com/o/uploads%2FMyApp.image.path?alt=media&token=75b06ea8-535c-488e-8d9e-89f02040a8e0",
      'address': "Begonia Drive",
      'parish':"Kingston",
      'severity': "Pothole",
      'latitude':18.012895,
      'longitude':-76.752201,
      'no_of_reports':0,
      'priority':0,
      'arterialPrio':0

    });



    widget.potholedatabaseref.push().set({
      'image': "",
      'address': "Ministry of Agriculture Rd",
      'parish':"Kingston",
      'severity': "Pothole or Plain",
      'latitude':18.017713,
      'longitude':-76.750112,
      'no_of_reports':0,
      'priority':0,
      'arterialPrio':0

    });





    widget.potholedatabaseref.push().set({
      'image': "",
      'address': "Savanna Rd",
      'parish':"Kingston",
      'severity': "Pothole",
      'latitude':17.998007,
      'longitude':-76.801942,
      'no_of_reports':0,
      'priority':0,
      'arterialPrio':0

    });



    widget.potholedatabaseref.push().set({
      'image': "",
      'address': "Savanna Rd",
      'parish':"Kingston",
      'severity': "Pothole",
      'latitude':18.027586,
      'longitude':-76.813885,
      'no_of_reports':0,
      'priority':0,
      'arterialPrio':0

    });



    widget.potholedatabaseref.push().set({
      'image': "",
      'address': "Leicester Ave",
      'parish':"Kingston",
      'severity': "Pothole or Plain",
      'latitude':18.036068,
      'longitude':-76.808757,
      'no_of_reports':0,
      'priority':0,
      'arterialPrio':0

    });






    widget.potholedatabaseref.push().set({
      'image': "",
      'address': "N E 21st Way",
      'parish':"Portmore",
      'severity': "Pothole",
      'latitude':17.954699,
      'longitude':-76.906815,
      'no_of_reports':0,
      'priority':0,
      'arterialPrio':0

    });



  }


  int arterialPriority(String address){
    int arterialPrio=0 ;
    //**Prio 1's***
    if((address=="Hope Rd")||
        (address=="Constant Spring Rd") ||
        (address=="Waterloo Rd") ||
        (address=="Trafalgar Rd") ||
        (address=="Lady Musgrave Rd") ||
        (address=="Molynes Rd") ||
        (address=="Hagley Park Rd") ||
        (address=="Half Way Tree Rd") ||
        (address=="Mona Rd") ||
        (address=="Barbrican Rd") ||
        (address=="Red Hills Rd") ||
        (address=="Roehampton Dr") ||
        (address=="Oxford Rd")
    ){
      arterialPrio = 1;

    }


    //**Prio 2's***
    if((address=="Washington Blvd") ||
        (address=="Meadowbrook Ave") ||
        (address=="Olivier Rd") ||
        (address=="Shortwood Rd") ||
        (address=="Liguanea Ave") ||
        (address=="Wellington Dr") ||
        (address=="Garden Blvd") ||
        (address=="Wellington Dr") ||
        (address=="Seaview Ave") ||
        (address=="Wellington Dr") ||
        (address=="Paddington Terrace")
    ){
      arterialPrio=2;

    }


    //**Prio 3's***
    if((address=="Lyndale Dr")||
        (address=="Bronze Rd") ||
        (address=="Silver Rd") ||
        (address=="Gold Rd") ||
        (address=="Marathon Dr")
    ){
      arterialPrio=2;

    }
    return arterialPrio;
  }
  Future uploadImageToFirebase(BuildContext context) async {

    String filename = widget.image.path;
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref('uploads/$filename');
    await ref.putFile(widget.image);
    String downloadUrl = await firebase_storage.FirebaseStorage.instance
        .ref('uploads/$filename')
        .getDownloadURL();


    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);

    String newkey = widget.potholedatabaseref.push().key;

    widget.potholedatabaseref.child(newkey).set({
      'image': downloadUrl,
      'address': widget.location,
      'parish': widget.location,
      'severity': widget.predict,
      'latitude':widget.latitude,
      'longitude': widget.longitiude,
      'no_of_reports':1,
      'priority':0,
      'arterialPrio':arterialPriority(widget.location), //check back on  how location is being sent over
      'land_surveyor':'',
      'contractor':'',
      'status':'accepted',
      'date_added': date.toString(),
      'userid':widget.user

    });

    widget.usersedatabaseref.child(widget.user).child(newkey).update({
      'description': 'J2EE complete Reference'
    });


    Fluttertoast.showToast(
        msg: "Thank you for Reporting a Pothole!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

    navg();

  }


  navg() async{
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
          new Myhomepage(widget.user)
      ),
    );
  }


  void getData(){
    widget.potholedatabaseref.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  void updateData(){
    widget.potholedatabaseref.child('1').update({
      'description': 'J2EE complete Reference'
    });
  }

  void deleteData(){
    widget.potholedatabaseref.child('1').remove();
  }
}