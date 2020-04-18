// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:ai_workout/components/auth.dart';

class DrawerList extends StatelessWidget {
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  
  DrawerList({ this.auth, this.logoutCallback, this.userId });
  
  signOut() async {
    try {
      await auth.signOut();
      logoutCallback();
      print("Logged out");
    } catch (e) {
      print(e);
    }
  }
  
  @override 
  Widget build(BuildContext context) {
    return new Drawer(
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
            leading: Icon(IconData(59530, fontFamily: 'MaterialIcons')),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushNamed(
                '/home', 
                arguments: HomeArguments(
                  auth,
                  logoutCallback,
                  userId
                )
              );
            }
          ),
          ListTile(
            leading: Icon(IconData(59564, fontFamily: 'MaterialIcons')),
            title: Text('Log Out'),
            onTap: () {
              signOut();
              // Navigator.of(context).pushNamed('/login');
            }
          )
        ],
      )
    );
  }
}

class HomeArguments {
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  
  HomeArguments( this.auth, this.logoutCallback, this.userId );
}