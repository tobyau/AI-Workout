import 'package:flutter/material.dart';
import 'dart:async';

import 'package:ai_workout/pages/root.dart';
import 'package:ai_workout/components/auth.dart';

class SplashScreen extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override 
  void initState() {
    super.initState();
    loadData();
  }
  
  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 2), onDoneLoading);
  }
  
  onDoneLoading() async {
    Navigator.of(
      context
    ).pushReplacement(
      MaterialPageRoute(
        builder: (context) => new RootPage(auth: new Auth())
      ));
  }
  
  @override 
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/splash1.jpg'),
          fit: BoxFit.fitWidth,
          alignment: Alignment.bottomLeft,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'AI-Workout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40
              )
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
            )
          ],
        )
      ),
    );
  }
}