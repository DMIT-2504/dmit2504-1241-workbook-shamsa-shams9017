import 'package:flutter/material.dart';
import 'package:flutter_profile_app_demo/widgets/profile_detail.dart';
import 'package:flutter_profile_app_demo/widgets/profile_image.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile App Demo')
        ),
        body: const Column(
          children: [
            // header
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Employee Profile',
                style: TextStyle(
                  fontFamily: 'Lobster',
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold
                )
              )
            ),
            // Profile image
           ProfileImage('images/sp_bob.jpg'),
            // Profile name
            Padding(padding: EdgeInsets.all(16.0),
            child: Text(
              'Spongebob',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              )
            )
            ),
            //positioning
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ProfileDetail('Position: ', 'QA Analyst')               
              ]
            )
          ]
        )
      ),
    );
  }
}
 