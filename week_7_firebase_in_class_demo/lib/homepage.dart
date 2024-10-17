import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: get current logged in user
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              //TODO: sign out using firebase here
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: Center(
        child: user != null
            ? Text(
                'Welcome, ${user.email}',
                style: TextStyle(fontSize: 20),
              )
            : Text(
                'No user found!',
                style: TextStyle(fontSize: 20),
              ),
      ),
    );
  }
}
