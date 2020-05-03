import 'package:flutter/material.dart';
import '../components/camera.dart';
import '../components/bndbox.dart';
import 'package:camera/camera.dart';
import 'dart:math';
import 'package:tflite/tflite.dart';

List<CameraDescription> cameras;

Future<List<CameraDescription>> getCameras() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  return cameras;
}



class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final List<dynamic> recognitions;
  final int imageHeight;
  final int imageWidth;
  final String customModel;
  final String model;
  
  CameraPage({
    this.cameras,
    this.imageHeight,
    this.imageWidth,
    this.recognitions,
    this.customModel,
    this.model
  });
  
  @override 
  State<StatefulWidget> createState() {
    return _CameraPage();
  }
}

class _CameraPage extends State<CameraPage> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  
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
  
  @override 
  void initState() {
    super.initState();
    var res = loadModel();
    print('Model Response: ' + res.toString());
  }

  
  @override 
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return FutureBuilder<List<CameraDescription>>(
      future: getCameras(),
      builder: (BuildContext context, AsyncSnapshot<List<CameraDescription>> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Please wait it\'s loading'));
        }
        else {
          return Scaffold(
            body: Stack(
              children: <Widget>[
                CameraScreen(
                  cameras: cameras,
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
              ]
            )
          );
        }
      },
    );
  }
}