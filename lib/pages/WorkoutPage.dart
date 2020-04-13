import 'package:flutter/material.dart';

import '../components/card_list.dart';

class WorkoutPage extends StatefulWidget {
  final String title; 
  final List<String> cards;
  
  WorkoutPage({ this.title, this.cards });
  
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
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30
              )
            ),
            padding: EdgeInsets.fromLTRB(30,130,30,20),
          ),
          CardList(items: widget.cards)
        ]
      )
    );
  }
}