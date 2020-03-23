// import 'package:flutter/material.dart';
// import 'package:ai_workout/components/auth.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key key, this.auth, this.userId, this.logoutCallback})
//       : super(key: key);

//   final BaseAuth auth;
//   final VoidCallback logoutCallback;
//   final String userId;

//   @override
//   State<StatefulWidget> createState() => new _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//     with SingleTickerProviderStateMixin{
//     TabController _tabController; 

//     @override
//     void initState(){
//       super.initState(); 
//       _tabController = new TabController(vsync: this, initialIndex: 1, length: 4);
//     }

//   signOut() async {
//     try {
//       await widget.auth.signOut();
//       widget.logoutCallback();
//     } catch (e) {
//       print(e);
//     }
//   }
  
//   // Widget showRandomText() {
//   //   return Center(
//   //     child: Text(
//   //       "Welcome to AI Workout",
//   //       textAlign: TextAlign.center,
//   //       style: TextStyle(fontSize: 30.0),
//   //     )
//   //   );
//   // }
  
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: new AppBar(
//         title: new Text('AI Workout'),
//         elevation: 0.7,
//         bottom: new TabBar(
//         controller: _tabController,
//         indicatorColor: Colors.white, 
//         tabs: <Widget>[
//           new Tab(icon: new Icon(Icons.camera_alt)),
//           new Tab(text: "WORKOUTS"),
//           new Tab(text: "PROFILE",),
//           new Tab(text: "SETTINGS",),
//         ],
//         ),
//           actions: <Widget>[
//             new FlatButton(
//                 child: new Text('Logout',
//                     style: new TextStyle(fontSize: 17.0, color: Colors.white)),
//                 onPressed: signOut)
//           ],
//         ),
//         //body: showRandomText()
//     );
//   }
// }