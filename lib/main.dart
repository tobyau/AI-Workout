// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import './route_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Ai-Workout',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouterGenerator.generateRoute,
          // case '/home':
          //   return MaterialPageRoute(
          //     builder: (_) => HomePage(
          //       auth: args.auth,
          //       logoutCallback: args.logoutCallback,
          //       userId: args.userId,
          //     )
          //   );
      // home: new SplashScreen(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}

