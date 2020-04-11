import 'package:flutter/material.dart';

import '../components/card_list.dart';

class WorkoutPage extends StatefulWidget {
  
  @override 
    State<StatefulWidget> createState() {
      return _WorkoutPageState();
    }
}

class _WorkoutPageState extends State<WorkoutPage> {
  
  
  @override 
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack( 
        children: <Widget>[
          Image.asset('assets/temp.jpg'),
          Container(
            child: Text(
              'Back',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30
              )
            ),
            padding: EdgeInsets.fromLTRB(30,130,30,20),
          ),
          CardList()
        ]
      )
    );
  }
}