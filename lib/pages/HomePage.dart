import 'package:flutter/material.dart';
import 'package:ai_workout/components/auth.dart';
import 'package:ai_workout/components/camera.dart';

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
    TabController _tabController; 

    @override
    void initState(){
      super.initState(); 
      _tabController = new TabController(vsync: this, initialIndex: 1, length: 4);
    }
  
    signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: new Icon(Icons.camera_alt)),
                Tab(text: "WORKOUTS"),
                Tab(text: "PROFILE",),
                Tab(text: "SETTINGS",),
              ],
            ),
            title: Text("AI-Workout"),
            elevation: 0.7,
            actions: <Widget>[
              new FlatButton(
                child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: signOut)
            ],
          ),
          body: TabBarView(
            children: [
              // Icon(Icons.camera_alt),
              new TakePictureScreen(camera: null),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_transit)
            ],
          ),
        ),
      ),
    );
  }

}