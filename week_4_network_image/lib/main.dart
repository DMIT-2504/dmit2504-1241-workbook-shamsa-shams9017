import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Network Image',
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}


//Stateful widget to track state of network image

class ImageScreen extends StatefulWidget{


}

// State class

class _ImageState extends State<ImageScreen>{
  
  String? _imageURL;

  //call the endpoint
  //callback to get the image
  Future<void> _fetchImage() async{
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));

    if(response.statusCode == 200){
      final data = json.decode(response.body);

      setState(() {
        _imageURL = data['message'];
      });
    }

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Image')
      ),
    
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 500,
            width: double.infinity, // this will take up the entire width of the screen
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
            ),
            child: _imageURL == null ? Center(child: Text('Please try again')) 
            : Image.network(
              _imageURL!,
              fit: BoxFit.contain  // this prevents cropping
            ) 
          ),

          SizedBox(
            height: 20
          ),
          ElevatedButton(onPressed: _fetchImage, 
            child: Text('Load Image')
          )
        ]
      ),
    ));
  }
}