import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:week7_firestore_inclass/pages/auth_page.dart';
import 'package:week7_firestore_inclass/pages/todo_page.dart';


Future<void> main() async {
  // firebase config 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}


class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _checkSignIn();
  }

  void _checkSignIn() {
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // redirect to user page if signed in
      home: _user == null ? AuthPage() : TodoPage(user: _user!),
    );
  }
}
