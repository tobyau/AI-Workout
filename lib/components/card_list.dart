import 'package:flutter/material.dart';
import '../pages/Tips.dart';
import 'package:ai_workout/components/auth.dart';

class CardList extends StatelessWidget{
  final List<String> items;
  final String imgPath; 
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  
  CardList({ this.items, this.imgPath, this.auth, this.userId, this.logoutCallback });
  
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Wrap(
        runSpacing: 30,
        children: items.map((item) => 
          GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TipsPage(
                    title: item,
                    imgPath: imgPath,
                    auth: auth,
                    logoutCallback: logoutCallback,
                    userId: userId,
                  )
                ),
              )
            },
            child: new Card(
              elevation: 5.0,
              child: new Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: ListTile(
                  leading: new Icon(
                      Icons.fitness_center,
                      color: Colors.black54,
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
      ),
      padding: EdgeInsets.fromLTRB(30,100,30,20),
    );    
  }
}