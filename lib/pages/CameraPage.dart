import 'package:flutter/material.dart';
import '../components/camera.dart';
import '../components/bndbox.dart';
import 'package:camera/camera.dart';
import 'dart:math';
import 'package:tflite/tflite.dart';

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
      model: "assets/posenet_mv1_075_float_from_checkpoints.tflite",
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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CameraScreen(
            cameras: widget.cameras,
            setRecognitions: _setRecognitions,
          ),
          BndBox(
            results: _recognitions == null ? [] : _recognitions,
            previewH: max(_imageHeight, _imageWidth),
            previewW: min(_imageHeight, _imageWidth),
            screenH: screen.height,
            screenW: screen.width,
            customModel: "Trikonasana",
          ),
        ]
      )
    );
  }
}