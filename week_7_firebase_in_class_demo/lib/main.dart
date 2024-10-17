import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:week_7_firebase_in_class_demo/homepage.dart';
import 'package:week_7_firebase_in_class_demo/login.dart';


Future<void> main() async {
  // firebase config 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Setup and Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthUserChecker(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}

// this widget acts as a middle man
// it checks if a user is authenticated
// based on auth state, it will reidirect
class AuthUserChecker extends StatelessWidget {
  const AuthUserChecker({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: get logged in user
    User? user = FirebaseAuth.instance.currentUser;
    return user == null ? LoginPage() : HomePage();
  }
}
