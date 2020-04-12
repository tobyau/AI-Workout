import 'package:flutter/material.dart';

import '../pages/HomePage.dart';

class CardList extends StatelessWidget{
  final List<String> items;
  
  CardList({ this.items });
  
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: CardItem(items),
      padding: EdgeInsets.fromLTRB(30,230,30,20),
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
        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage()
              ),
            )
          },
          child: new Card(
            elevation: 5.0,
            child: new Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: ListTile(
                leading: new Icon(
                    Icons.directions_car,
                    color: Colors.amber,
                    size: 40
                  ),
                title: new Column(
                  children: <Widget>[
                    Text(item)
                  ],
                ),
                trailing: new Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 17.0),
                      child: Icon(Icons.arrow_forward_ios)
                    )
                  ],
                )
              ),
            )
          )
        )
      ).toList(),
    );
  }
}

