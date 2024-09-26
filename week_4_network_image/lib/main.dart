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
      home: ImageScreen() // stateful widget passed here
    );
  }
}


//Stateful widget to track state of network image

class ImageScreen extends StatefulWidget{

  //this function instantiates a state object
  //the state object handles the changes to the data (state)
  @override
  _ImageState createState(){
    return _ImageState();
  }
}

// State class

class _ImageState extends State<ImageScreen>{
  
  String? _imageURL; //variable to track image data
  int _likes = 0; //Like counter
  int _disLikes = 0; // dislike counter

  //call the endpoint
  //callback to get the image
  Future<void> _fetchImage() async{
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));

    if(response.statusCode == 200){
      final data = json.decode(response.body);
      
      //rebuild UI once image is received
      setState(() {
        _imageURL = data['message'];
      });
    }

  }
  
  //function to handle image change and likes
  void _onTap(){
    _fetchImage().then((_){
      setState(() {
        _likes += 1;
      });
    });
  }
  
  // handle image change and dislikes
  void _onLongPress(){
        _fetchImage().then((_){
          setState(() {
          _disLikes += 1;
      });
    });
  }

  @override
  void initState(){
    super.initState();
    //perform any specific initializations
    _fetchImage();
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
          // image displayed here
          // wrap container with gesturedetector
          GestureDetector(
            onTap: _onTap,
            onLongPress: _onLongPress,
            child: Container(
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
          ),
          
          //space between image and button
          SizedBox(
            height: 20
          ),
          LikesDislikesText(like: true, num: _likes),

          LikesDislikesText(like: false, num: _disLikes),

        ]
      ),
    ));
  }
}

//display likes and dislikes counters with stateless widget 
class LikesDislikesText extends StatelessWidget{

  final bool like; // use this to determine which label to use
  final int num; // value for like or dislike

  const LikesDislikesText({this.like = true, this.num = 0, super.key});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0
      ),
      child: Row(
        children: <Widget>[
          //label, either like or dislike
          Text(
            like ? "Likes: " : "Dislikes: ",
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold
            )
          ),
          // value for like or dislike
          Text(
            '$num',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold
            )
          )
        ]
      )
      );
  }
}