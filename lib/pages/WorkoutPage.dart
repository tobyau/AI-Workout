import 'package:flutter/material.dart';

import '../components/card_list.dart';

class WorkoutPage extends StatefulWidget {
  final String title; 
  // final List<String> cards;
  
  // WorkoutPage({ this.title, this.cards });
  WorkoutPage({ this.title });
  
  @override 
    State<StatefulWidget> createState() {
      return _WorkoutPageState();
    }
}

class _WorkoutPageState extends State<WorkoutPage> with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController controller; 
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  bool isClicked = false;
    
  @override 
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this
    );
  }
  
  List<String> cards(String title) {
    switch(title) {
      case "BACK":
         return ["Lats", "Upper Back"];
    }
  }
  
  _handleOnPressed() {
    setState(() {
      isClicked = !isClicked;
      // isClicked ? controller.forward() : controller.reverse();
    });
  }
  
  _displayDrawer(BuildContext context) {
    _scaffoldKey.currentState.openDrawer();
  }
  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    image: AssetImage('assets/water.jpeg'),
                    fit: BoxFit.cover
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.accessible),
                title: Text('Item 1'),
                onTap: () {
                  Navigator.of(context).pop();
                }
              ),
              ListTile(
                leading: Icon(Icons.accessible),
                title: Text('Log Out'),
                onTap: () {
                  // Navigator.of(context).pop();
                  // signOut();
                }
              )
            ],
          )
        ),
      body: SingleChildScrollView(
        child: Stack( 
          children: <Widget>[
            Image.asset('assets/temp.jpg'),
            Container(
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30
                )
              ),
              padding: EdgeInsets.fromLTRB(30,130,30,20),
            ),
            CardList(items: cards(widget.title)),
            Positioned(
              left: 20.0,
              top: 30.0,
              child: IconButton(
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: controller,
                  color: Colors.white,
                ),
                onPressed: () => {
                  _handleOnPressed(),
                  _displayDrawer(context)
                },
              ),
            ),
          ]
        )
      )
    );
  }
}