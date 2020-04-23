import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:tflite/tflite.dart';



const PrimaryColor = const Color(0xFFFFFF);
class ResultsPage extends StatefulWidget {
  
  @override 
    State<StatefulWidget> createState() {
      return _ResultsPageState();
    }
}
class _ResultsPageState extends State<ResultsPage> {
  VideoPlayerController _controller;
  bool _isPlaying = false;
  
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
        ..addListener(() {
          final bool isPlaying = _controller.value.isPlaying;
          if(isPlaying != _isPlaying){
            setState((){
              _isPlaying = isPlaying;
            });
          }
        })
      ..initialize().then((_){
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
        });
      });
  }

  @override 
  Widget build(BuildContext context){
    //* 
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),

        appBar:AppBar(
          title: Image.asset('assets/stats.png', fit: BoxFit.cover),
          backgroundColor: PrimaryColor,
        ), 
        //body: Text("Hello Flutter"),
        ),
      );
  }
}

