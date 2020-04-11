import 'package:flutter/material.dart';

import '../pages/HomePage.dart';

class CardList extends StatelessWidget{
  final List<String> items = ['Lats', 'Upper Back', 'Lower Back', 'Lats', 'Upper Back', 'Lower Back'];
  
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: CardItem(items),
      padding: EdgeInsets.fromLTRB(30,235,30,20),
    );    
  }
}

class CardItem extends StatelessWidget {
  final List<String> items;
  
  CardItem(this.items);
  
  @override 
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 30,
      children: items.map((item) => 
        RaisedButton(
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
          },
          color: Colors.white,
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Icon(
                                          Icons.directions_bike,
                                          color: Colors.amber,
                                          size: 40,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(item)
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Align(
                                      child: Icon(
                                        Icons.arrow_forward_ios
                                      )
                                    ),
                                  )
                                ],
                              ),
                              
                            ],
                          ))
                    ],
                  ),
                )
              ]
            ),
          ),
        )).toList(),
      );
  }
}