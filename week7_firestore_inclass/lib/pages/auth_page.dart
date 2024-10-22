import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'todo_page.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool isSignIn = true; //used in layout

  // The !isSignIn flips the value of isSignIn. 
  // If isSignIn is true, it becomes false,
  // if it's false, it becomes true
  void _toggleAuthMode() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  void _signIn() async {
    // this returns a UserCredential object that stores the user data
    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (userCredential.user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TodoPage(user: userCredential.user!)),
      );
    }
  }

  void _signUp() async {
    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    final User? user = userCredential.user;

    if (user != null) {
      // Add the new user to Firestore
      // Firestore automatically creates collections and documents as needed. 
      // if the users collection does not exist, Firestore will create it the first time you try to add a document
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => TodoPage(user: user)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auth Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!isSignIn)
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
            if (!isSignIn)
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isSignIn ? _signIn : _signUp,
              child: Text(isSignIn ? 'Sign In' : 'Sign Up'),
            ),
            TextButton(
              onPressed: _toggleAuthMode,
              child: Text(isSignIn ? 'Don\'t have an account? Sign Up' : 'Already have an account? Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
