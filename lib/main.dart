// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';
// import 'package:geolocator/geolocator.dart';
//
//
// void main() => runApp(MaterialApp(
//   home: FirstRoute(),
// ));
//
// class MyApp extends StatefulWidget {
//   @override
//   _Homepage createState() => _Homepage();
// }
//
// class _Homepage extends State<MyApp> {
//   List _outputs;
//   File _image;
//   bool _loading = false;
//   final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
//   Position _currentPosition;
//   String _currentAddress;
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//
//     _loading = true;
//
//     loadModel().then((value) {
//       setState(() {
//         _loading = false;
//       });
//     });
//   }
//
//   _getCurrentLocation() {
//     geolocator
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//         .then((Position position) {
//       setState(() {
//         _currentPosition = position;
//       });
//
//       _getAddressFromLatLng();
//     }).catchError((e) {
//       print(e);
//     });
//   }
//
//   _getAddressFromLatLng() async {
//     try {
//       List<Placemark> p = await geolocator.placemarkFromCoordinates(
//           _currentPosition.latitude, _currentPosition.longitude);
//
//       Placemark place = p[0];
//
//       setState(() {
//         _currentAddress =
//         "${place.locality}, ${place.postalCode}, ${place.country}";
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Teachable Machine Learning'),
//       ),
//       body: _loading
//           ? Container(
//         alignment: Alignment.center,
//         child: CircularProgressIndicator(),
//       )
//           : Container(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _image == null ? Container() : Image.file(_image),
//             SizedBox(
//               height: 20,
//             ),
//             _outputs != null
//                 ? Text(
//               "${_outputs[0]["label"]}",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20.0,
//                 background: Paint()..color = Colors.white,
//               ),
//             )
//                 : Container(),
//             Row(
//               children: <Widget>[
//                 Icon(Icons.location_on),
//                 SizedBox(
//                   width: 8,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         'Location',
//                         style: Theme.of(context).textTheme.caption,
//                       ),
//                       if (_currentPosition != null &&
//                           _currentAddress != null)
//                         Text(_currentAddress,
//                             style:
//                             Theme.of(context).textTheme.bodyText2),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: 8,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: pickImage,
//         child: Icon(Icons.image),
//       ),
//     );
//   }
//
//   pickImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     if (image == null) return null;
//     setState(() {
//       _loading = true;
//       _image = image;
//     });
//     classifyImage(image);
//   }
//
//   classifyImage(File image) async {
//     var output = await Tflite.runModelOnImage(
//       path: image.path,
//       numResults: 2,
//       threshold: 0.5,
//       imageMean: 127.5,
//       imageStd: 127.5,
//     );
//     setState(() {
//       _loading = false;
//       _outputs = output;
//     });
//   }
//
//   loadModel() async {
//     await Tflite.loadModel(
//       model: "assets/model_unquant.tflite",
//       labels: "assets/labels.txt",
//     );
//   }
//
//   @override
//   void dispose() {
//     Tflite.close();
//     super.dispose();
//   }
// }
//
//
//
// class FirstRoute extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('First Route'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text('Open route'),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => MyApp()),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

// import 'dart:js';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';


void main() => runApp(MaterialApp(
      home: _Homepage(),
    ));

class _Homepage extends StatefulWidget {
  @override
  home createState() => home();
}

class home extends State<_Homepage> {
  // DateTime now = new DateTime.now();
  // DateTime date = new DateTime(now.year, now.month, now.day);
  // String todays_date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  List _outputs;
  File _image;
  bool _loading = false;


  @override
  void initState() {
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
            "${place.locality}, ${place.postalCode}, ${place.country}";
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

        body: Container(
      decoration: new BoxDecoration(color: Colors.black54),
      child: Column(
        children: [
          //row 1
          SizedBox(height: MediaQuery.of(context).size.height / 18),
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

  Widget row3 = Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      padding: const EdgeInsets.only(bottom: 30.0, top: 30.0),
      color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 200),
            child: Text("Upload from Camera",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                    background: Paint()..color = Colors.white)),
          ),
          Text("Logo",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  background: Paint()..color = Colors.white))
        ],
      ));



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
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
          new MyApp(location: _currentAddress,predict: _outputs[0]["label"],image: _image)),
    );
  }
  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}

class MyApp extends StatefulWidget {
  @override
  final String location;
  final String predict;
  final File image;
  final databaseReference = FirebaseDatabase.instance.reference();


  MyApp({Key key, this.location, this.predict,this.image}) : super(key: key);

  testing createState() => testing();
}

class testing extends State<MyApp> {
  // List _outputs;
  // File _image;
  // bool _loading = false;

  @override
  void initState() {
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
                  )
,
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
                    onPressed: () => { createRecord()},
                    child: new Text('Submit Report'),
                    elevation: 5,
                  ),
                ],

              ),
            ),

    );
  }


  void createRecord(){
    widget.databaseReference.push().set({
      'title': widget.image.path,
      'location': widget.location
    });

  }

  void getData(){
    widget.databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  void updateData(){
    widget.databaseReference.child('1').update({
      'description': 'J2EE complete Reference'
    });
  }

  void deleteData(){
    widget.databaseReference.child('1').remove();
  }
}
