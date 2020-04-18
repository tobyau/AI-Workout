import 'package:flutter/material.dart';
import 'package:ai_workout/components/auth.dart';
import 'package:ai_workout/components/camera.dart';
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
    
    int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
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
                  ),
              ),
              SizedBox(width: 4.0),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        title,
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
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(200.0),
                    //     color: Colors.green),
                  ),
                ),
                Positioned(
                  bottom: 100.0,
                  left: 150.0,
                  child: Container(
                      height: 300.0,
                      width: 300.0,
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(150.0),
                      //     color: Colors.red,
                      // ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 15.0),
                        Container(
                          alignment: Alignment.topLeft,
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 2.0),
                              ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width - 120.0),
                      
                        SizedBox(height: 15.0),
                      ],
                    ),
                    SizedBox(height: 50.0),
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
            itemCard('BACK', 'assets/ottoman.jpg'),
            itemCard('CHEST', 'assets/anotherchair.jpg'),
            itemCard('LEGS', 'assets/chair.jpg'),
            itemCard('ARMS', 'assets/chair.jpg'),
            itemCard('ARMS', 'assets/chair.jpg')
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
    );
  }
}