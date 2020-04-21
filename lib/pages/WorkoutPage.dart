import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../components/drawer.dart';
import '../components/card_list.dart';
import 'package:ai_workout/components/auth.dart';

class WorkoutPage extends StatefulWidget {
  final String title; 
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  
  WorkoutPage({ this.title, this.auth, this.userId, this.logoutCallback });
  
  @override 
    State<StatefulWidget> createState() {
      return _WorkoutPageState();
    }
}

class _WorkoutPageState extends State<WorkoutPage> with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController controller; 
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  List<String> back = ["Lats", "Upper Back", "Lower Back", "Middle Back"];
  List<String> chest = ["Upper Chest", "Middle Chest", "Lower Chest"];
  List<String> legs = ["Quadriceps", "Glutes", "Hamstrings", "Calves"];
  List<String> arms = ["Biceps", "Triceps", "Forearms"];
  List<String> shoulders = ["Front Delts", "Side Delts", "Rear Delts"];
  List<String> workouts;
  
  bool isClicked = false;
    
  @override 
  void initState() {
    super.initState();
    cards(widget.title);
    
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this
    );
  }
  
  void cards(String title) {
    switch(title) {
      case "BACK":
        workouts = back;
        break;
      case "CHEST":
        workouts = chest;
        break;
      case "LEGS":
        workouts = legs;
        break;
      case "ARMS":
        workouts = arms;
        break;
      case "Shoulders":
        workouts = shoulders;
        break;
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
      drawer: DrawerList(
        auth: widget.auth, 
        logoutCallback: widget.logoutCallback,
        userId: widget.userId
      ),
      body: SlidingUpPanel(
        panel: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                child: Center(
                  child: Text(
                    "Workouts",
                    style: TextStyle(
                      fontSize: 30
                    )
                  )
                ),
              ),
              CardList(
                items: workouts,
                auth: widget.auth,
                logoutCallback: widget.logoutCallback,
                userId: widget.userId
              ),
            ]
          )
        ),
        header: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.5),
          child: Icon(
            IconData(57952, fontFamily: 'MaterialIcons')
          )
        ),
        minHeight: 465,
        maxHeight: 600,
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.black
          )
        ],
        borderRadius: new BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        ),
        body: Stack( 
          children: <Widget>[
            Image(
              image: AssetImage('assets/squat.jpg'),
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 250,
              left: 30,
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27
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
          ]
        )
      )
    );
  }
}