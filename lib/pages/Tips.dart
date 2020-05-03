import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

import 'package:ai_workout/components/auth.dart';
import '../components/drawer.dart';
import '../components/camera.dart';
import '../components/bndbox.dart';


class TipsPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String model;
  final String customModel;
  final String title; 
  final String imgPath;
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  
  TipsPage({ 
    this.title, 
    this.imgPath, 
    this.auth, 
    this.userId, 
    this.logoutCallback,
    this.cameras, 
    this.model, 
    this.customModel });
  
  @override 
    State<StatefulWidget> createState() {
      return _TipsPage();
    }
}

class _TipsPage extends State<TipsPage> {

  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;

  @override
  void initState() {
    super.initState();
    var res = loadModel();
    print('Model Response: ' + res.toString());
  }
  
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isClicked = false;
  
  List<String> testTips = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do", 
    "eiusmod tempor incididunt ut labore et dolore magna aliqua", 
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco", 
    "laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure"
  ];
  
  _handleOnPressed() {
    setState(() {
      isClicked = !isClicked;
    });
  }
  
  _displayDrawer(BuildContext context) {
    _scaffoldKey.currentState.openDrawer();
  }

  _setRecognitions(recognitions, imageHeight, imageWidth) {
    if (!mounted) {
      return;
    }
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }
    loadModel() async {
    return await Tflite.loadModel(
      model: widget.model,
    );
  }

  Widget _tips() {
    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            children: testTips.map((tip) => 
              Padding(
                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: Text(
                  (testTips.indexOf(tip) + 1).toString() + ' : ' + tip,
                  style: TextStyle(
                    fontSize: 21
                  )
                ),
              )
            ).toList()
          ),
        ],
      ),
      padding: EdgeInsets.only(top: 40, bottom: 30.0)
    );
  }
  
  @override 
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerList(
        auth: widget.auth, 
        logoutCallback: widget.logoutCallback,
        userId: widget.userId
      ),
      body: Stack(
        children: <Widget>[
          Camera(
            cameras: widget.cameras,
            setRecognitions: _setRecognitions,
          ),
          BndBox(
            results: _recognitions == null ? [] : _recognitions,
            previewH: max(_imageHeight, _imageWidth),
            previewW: min(_imageHeight, _imageWidth),
            screenH: screen.height,
            screenW: screen.width,
            customModel: widget.customModel,
          ),
          Image(
            image: AssetImage(widget.imgPath),
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 250,
            left: 30,
            child: Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30
              )
            ),
          ),
          Positioned(
            left: 15.0,
            top: 40.0,
            child: IconButton(
              icon: Icon(
                IconData(
                  57953, 
                  fontFamily: 'MaterialIcons', 
                  matchTextDirection: true,
                ),
                color: Colors.white,
                size: 45,
                
              ),
              onPressed: () => {
                _handleOnPressed(),
                _displayDrawer(context)
              },
            ),
          ),
          
          Positioned(
            top: 130,
            left: MediaQuery.of(context).size.width * .43,
            child: Container(
              child:  Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 55,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 70, 
                    color: Colors.grey
                  )
                ]
              ),
            )
          ),
          
          Container(
            height: MediaQuery.of(context).size.height * .7,
            margin: EdgeInsets.only(top: 305),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), 
                topRight: Radius.circular(40)
              ),
              color: Colors.white
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 50, 10, 0),
                    child: Text(
                      "TIPS",
                      style: TextStyle(
                        fontSize: 30
                      )
                    )
                  ),
                  _tips(),
                ],
              )
            ),
          ),
            
          Positioned(
            top: 275,
            child: Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * .42),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20, 
                    color: Colors.grey
                  ),
                ]
              ),
              child: Icon(
                Icons.photo_camera,
                size: 30,
                color: Colors.white
              )
            ),
          ),
          
          
        ],
      )
      
      // body: SlidingUpPanel(
      //   panel: SingleChildScrollView(
      //     child: Stack(
      //       children: <Widget>[
      //         Padding(
      //           padding: EdgeInsets.fromLTRB(0, 30, 10, 0),
      //           child: Center(
      //             child: Text(
      //               "TIPS",
      //               style: TextStyle(
      //                 fontSize: 30
      //               )
      //             )
      //           ),
      //         ),
      //         _tips(),
      //       ]
      //     )
      //   ),
      //   minHeight: 600,
      //   maxHeight: 600,
      //   boxShadow: [
      //     BoxShadow(
      //       blurRadius: 20.0,
      //       color: Colors.black
      //     )
      //   ],
      //   borderRadius: new BorderRadius.only(
      //     topLeft: Radius.circular(30),
      //     topRight: Radius.circular(30)
      //   ),
      //   body: Stack( 
      //     children: <Widget>[
      //       Image(
      //         image: AssetImage('assets/squat.jpg'),
      //         fit: BoxFit.cover,
      //       ),
      //       Positioned(
      //         top: 250,
      //         left: 30,
      //         child: Text(
      //           widget.title,
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 27
      //           )
      //         ),
      //       ),
      //       Positioned(
      //         left: 15.0,
      //         top: 40.0,
      //         child: IconButton(
      //           icon: Icon(
      //             IconData(
      //               57953, 
      //               fontFamily: 'MaterialIcons', 
      //               matchTextDirection: true,
      //             ),
      //             color: Colors.white,
      //             size: 45,
                  
      //           ),
      //           onPressed: () => {
      //             _handleOnPressed(),
      //             _displayDrawer(context)
      //           },
      //         ),
      //       ),
      //       Positioned(
      //         top: 260,
      //         child: Container(
      //           margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2.3),
      //           padding: EdgeInsets.all(15),
      //           decoration: BoxDecoration(
      //             color: Colors.black,
      //             borderRadius: BorderRadius.circular(50)
      //           ),
      //           child: Icon(
      //             Icons.photo_camera,
      //             size: 30,
      //             color: Colors.white
      //           )
      //         ),
      //       )
      //     ]
      //   )
      // )
    );
  }
}