import 'package:flutter/material.dart';
import './pages/splash_screen.dart';
import 'package:ai_workout/pages/root.dart';
import 'package:ai_workout/components/auth.dart';
import './pages/HomePage.dart';
import './components/drawer.dart';


class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/home':
        final HomeArguments args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => HomePage(
              auth: args.auth,
              logoutCallback: args.logoutCallback,
              userId: args.userId,
            )
          );
      default: 
        return MaterialPageRoute(builder: (_) => RootPage(auth: new Auth()));
    }
  }

}