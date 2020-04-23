import 'package:flutter/material.dart';
import 'package:ai_workout/components/auth.dart';
//import 'package:ai_workout/components/camera.dart';
import '../components/drawer.dart';

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
    Animation<double> animation;
    AnimationController controller; 
    
    bool isClicked = false;
    List<String> workouts = ['Abs', 'Arms', 'Back', 'Chest', 'Legs', 'Shoulders']; 
    
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    
    @override
    void initState(){
      super.initState(); 
      controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this
      );
    }
  
    signOut() async {
      try {
        await widget.auth.signOut();
        widget.logoutCallback();
      } catch (e) {
        print(e);
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
  
  Widget itemCard(String title, String imgPath) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => WorkoutPage(
              title: title,
              auth: widget.auth,
              logoutCallback: widget.logoutCallback,
              userId: widget.userId,
            )
          )
        )
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 15.0, 
          right: 15.0, 
          top: 15.0
        ),
        child: Container(
          height: 100.0,
          width: 300,//double.infinity,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                width: 100.0,
                height: 150.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imgPath), fit: BoxFit.cover)),
              ),
              SizedBox(width: 4.0),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
  
  Widget homePageWigets() {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 350.0,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
                Positioned(
                  bottom: 50.0,
                  right: 100.0,
                  child: Container(
                    height: 400.0,
                    width: 400.0,
                  ),
                ),
                Positioned(
                  bottom: 100.0,
                  left: 150.0,
                  child: Container(
                      height: 300.0,
                      width: 300.0,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    SizedBox(height: 100.0),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Hey there, let's workout!",
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Select a body part from below to view a selection of workouts.",
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(5.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search,
                                    color: Colors.black,
                                    size: 30.0),
                                contentPadding:
                                    EdgeInsets.only(left: 15.0, top: 15.0),
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Quicksand'))),
                      ),
                    ),
                    SizedBox(height: 10.0)
                  ],
                )
              ],
            ),
            SizedBox(height: 10.0),
            itemCard('BACK', 'assets/temp.jpg'),
            itemCard('CHEST', 'assets/temp.jpg'),
            itemCard('LEGS', 'assets/temp.jpg'),
            itemCard('ARMS', 'assets/temp.jpg'),
            itemCard('CORE', 'assets/temp.jpg')
          ],
        )
      ],
    );
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
        body: Stack(
          children: <Widget>[
            // WorkoutPage(
            //   title: 'Workouts',
            //   cards: workouts,
            // ),
            homePageWigets(),
            Positioned(
              left: 15.0,
              top: 50.0,
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
    );
  }
}