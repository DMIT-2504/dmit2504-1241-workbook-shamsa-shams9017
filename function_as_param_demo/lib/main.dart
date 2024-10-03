import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CustomWidgetStateful(
            nameProvider: fetchGreeting,
          ),
        ),
      ),
    );
  }
}

class CustomWidgetStateful extends StatefulWidget {
  final Future<String> Function({required String name}) nameProvider;

  const CustomWidgetStateful({
    Key? key,
    required this.nameProvider,
  }) : super(key: key);

  @override
  _CustomWidgetStatefulState createState() => _CustomWidgetStatefulState();
}

class _CustomWidgetStatefulState extends State<CustomWidgetStateful> {
  String _displayText = '';

  @override
  void initState() {
    super.initState();
    //_fetchName();

    widget.nameProvider(name: 'ABCD').then((value) {
              setState(() {
                _displayText = value;
              });
            });
  }

  // void _fetchName() async {
  //   String name = await widget.nameProvider(name: 'John Doe');
  //   setState(() {
  //     _displayText = name;
  //   });
  // }

  void _fetchName(String name) async {
    String greeting = await widget.nameProvider(name: name);
    setState(() {
      _displayText = greeting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_displayText),
        SizedBox(height: 20),
        ElevatedButton(
          // onPressed: _fetchName,
          onPressed: () {
           // _fetchName('Shams');
           //api call
            widget.nameProvider(name: 'Shams').then((value) {
              setState(() {
                _displayText = value;
              });
            });
          },
          child: Text('get Name'),
        ),
      ],
    );
  }
}

Future<String> fetchGreeting({required String name}) async {
  await Future.delayed(Duration(seconds: 2));
  return 'Hello, $name!';
}
