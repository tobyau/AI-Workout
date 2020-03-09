import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override 
  _HomePageState createState() => new _HomePageState(); 
}

class _HomePageState extends State<HomePage> 
  with SingleTickerProviderStateMixin{
    TabController _tabController; 

    @override
    void initState(){
      super.initState(); 
      _tabController = new TabController(vsync: this, initialIndex: 1, length: 4);
    }
  
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("AI-Workout"), 
        elevation: 0.7,
        bottom: new TabBar(
        controller: _tabController,
        indicatorColor: Colors.white, 
        tabs: <Widget>[
          new Tab(icon: new Icon(Icons.camera_alt)),
          new Tab(text: "WORKOUTS"),
          new Tab(text: "PROFILE",),
          new Tab(text: "SETTINGS",),
        ],
        ),
      ),
    );
  }
}