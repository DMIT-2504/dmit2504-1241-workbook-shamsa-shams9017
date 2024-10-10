import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

// Create an app that creates and updates a text file
// It should be stored in your device
// It should retrieve and display content of your file


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: HomePage()
      ),
    );
  }
}


//Step 1: create a homepage that displays the content

class HomePage extends StatefulWidget{
  const HomePage({super.key});

@override
_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  String? _savedQuote;

  //Step 2: create function that would get qouotes from API and saves it to a file
  void _getAndSaveQUote() async {
    try{
      const quoteEndPoint = 'https://dummyjson.com/quotes/random';

      //get quote from API
      var response = await http.get(Uri.parse(quoteEndPoint));
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        String quoteText = jsonResponse['quote'];

        //get access to the directory
        //this is the access to internal storage
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/quote.txt'; //get full path 

        //create a file object 
        final file = File(filePath);

        //write the quote to the file
        await file.writeAsString(quoteText);

        setState((){
          _savedQuote = "Quote saved successfully!";
        });
      }
    }
    catch(e){
      print('Error: $e');
    }
  }

  //Step 3 write a function to retrieve content from saved file
  void _readQuoteFromFile() async {
    try{
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/quote.txt'; //get full path 

        //create a file object 
        final file = File(filePath);

        //check if file exists
        if(file.existsSync()){
          String quote = await file.readAsString();
          setState((){
            _savedQuote = quote;
          });
        }
    }
    catch(e){
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Save and Read From File')
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _getAndSaveQUote, 
              child: Text('Get and Save Quote')),
            SizedBox(height:20),
                        ElevatedButton(
              onPressed: _readQuoteFromFile, 
              child: Text('Read Saved Quote')),
            SizedBox(height:20),
            _savedQuote != null 
            ? Text(_savedQuote!,
            style: TextStyle(fontSize: 18)
            ) : Text('No Quotes Available')
          ]
        )
      )
      );

  }
}
