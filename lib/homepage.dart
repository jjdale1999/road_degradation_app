import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:road_degradation_app/main.dart';

class HomePage extends State<Myhomepage> {
  // DateTime now = new DateTime.now();
  // DateTime date = new DateTime(now.year, now.month, now.day);
  // String todays_date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  List _outputs;
  File _image;
  bool _loading = false;
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // FirebaseUser user = await _firebaseAuth.currentUser();

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
  void initState() {
    initializeFlutterFire();

    _getCurrentLocation();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  get_Address() {
    return _currentAddress;
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      setState(() {
        _currentAddress =
        "${place.locality},${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('First Route'),
      // ),
      //
        body: Container(
          decoration: new BoxDecoration(color: Colors.black54),
          child: Column(
            children: [

              SizedBox(height: MediaQuery.of(context).size.height / 18),
              //row 1
              Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Logo",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              )),
                          Text(DateFormat("MMM dd,yyyy").format(DateTime.now()),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ))
                        ],
                      ),
                      SizedBox(height: 10),
                      (_currentPosition != null && _currentAddress != null)
                          ? Text(_currentAddress,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ))
                          : Text("No Location Found",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          )),
                    ],
                  )),
              SizedBox(height: 40),
              //row2
              Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  padding: const EdgeInsets.only(bottom: 40.0, top: 40.0),
                  // color: Colors.redAccent,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text("Upload from Gallery",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                            )),
                      ),

                      // Text( "Logo",style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 20.0,
                      //     background: Paint()..color = Colors.white))

                      InkWell(
                        onTap:
                        pickImage,
                        //   pickImage
                        // handle your image tap here
                        child: Image.asset(
                          'assets/up_gal_icon.png',
                          fit: BoxFit.cover, // this is the solution for border
                          width: 110.0,
                          height: 110.0,
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 30),
              //row3
              Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  padding: const EdgeInsets.only(bottom: 40.0, top: 40.0),
                  // color: Colors.blueGrey,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlueAccent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text("Upload from Camera",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                            )),
                      ),
                      InkWell(
                        onTap:
                        takeImage,
                        //   pickImage
                        // handle your image tap here
                        child: Image.asset(
                          'assets/up_cam_icon.png',
                          fit: BoxFit.cover, // this is the solution for border
                          width: 110.0,
                          height: 110.0,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }





  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  takeImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
    navg();
  }

  navg() async{
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
          new MyApp(user:widget.user,location: _currentAddress,latitude: _currentPosition.latitude,longitiude: _currentPosition.longitude,predict: _outputs[0]["label"],image: _image)),
    );
  }
  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
