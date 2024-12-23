import 'package:flutter/material.dart';
import 'package:week_05_nested_navigation/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(settingsHomeRoute);
        },
        child: const Icon(Icons.settings),
      ),
    );
  }
}
