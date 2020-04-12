import 'package:flutter/material.dart';
import 'package:ai_workout/components/auth.dart';
import 'package:ai_workout/components/camera.dart';

import './WorkoutPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}


class _HomePageState extends State<HomePage> 
  with SingleTickerProviderStateMixin{
    @override
    void initState(){
      super.initState(); 
    }
  
    signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }
  
  int _currentIndex = 0;
  final List<Widget> _children = [
    TakePictureScreen(camera: null),
    WorkoutPage(
      title: 'Back', 
      cards: ['Lats', 'Upper Back', 'Lower Back', 'Lats', 'Upper Back', 'Lower Back']),
    Center(
      child: Icon(Icons.directions_bike),
    )
  ];
  
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("AI-Workout"),
          elevation: 0.7,
          actions: <Widget>[
            new FlatButton(
              child: new Text('Logout',
              style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: signOut)
          ],
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex, 
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.accessibility),
              title: Text('Workout'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
            )
          ],
        ),
      )
    );
  }
}