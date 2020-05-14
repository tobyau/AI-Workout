import 'package:flutter/material.dart';
import 'dart:async';

import 'package:ai_workout/pages/root.dart';
import 'package:ai_workout/components/auth.dart';

class SplashScreen extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override 
  void initState() {
    super.initState();
    loadData();
  }
  
  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }
  
  onDoneLoading() async {
    Navigator.of(
      context
    ).pushReplacement(
      MaterialPageRoute(
        builder: (context) => new RootPage(auth: new Auth())
      ));
  }
  
  @override 
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                   child: Image(
                    image: AssetImage('assets/logo_final.png'),
                      height: 200,
                      width: 200,
                      fit: BoxFit.fitWidth,
                      color: Colors.grey[300],
                      colorBlendMode: BlendMode.darken,
                      //alignment: Alignment.bottomLeft,
                   ),
                  ),
                    Text(
                        'AI-Workout',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 30.0,
                            color: Colors.black,
                          ),
                        ),
                  //  Align(
                  //    alignment: Alignment.bottomCenter,
                      
                  //   // child: SizedBox(
                  //   //   height: 15,
                  //   //   width: 200,
                  //     child: LinearProgressIndicator(
                  //       backgroundColor: Colors.white,
                  //         valueColor: AlwaysStoppedAnimation<Color>(Colors.blue,),
                  //         value: 0.8,
                  //     ),
                  //   //),
                  //   ),

                
                  // bottomSheet: Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child:LinearProgressIndicator(
                  //         backgroundColor: Colors.white,
                  //         valueColor: AlwaysStoppedAnimation<Color>(Colors.blue,),
                  //         value: 0.8,
                  //       ),
                  //   ),
                ],
              ),
          
        ),
    );
  }
}




















// return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/splash1.jpg'),
//           fit: BoxFit.contain,
//           alignment: Alignment.bottomLeft,
//         ),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'AI-Workout',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 40
//               )
//             ),
//             CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
//             )
//           ],
//         )
//       ),
//     );