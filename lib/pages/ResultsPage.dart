import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  
  @override 
    State<StatefulWidget> createState() {
      return _ResultsPageState();
    }
}

class _ResultsPageState extends State<ResultsPage> {
  

  @override 
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          //backgroundColor: Colors.white,
          expandedHeight: 150.0,
          floating: true,
          pinned: true, 
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Results', 
              style: TextStyle(
                color: Colors.white,
                fontSize: 15
              ) 
            ),
          ),
        ),
      ]
    );
  }
}