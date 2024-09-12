import 'dart:convert';
import 'dart:io';

import 'package:dart_async_app_2/dart_async_app_2.dart' as dart_async_app_2;
import 'package:http/http.dart' as http;

//First step is to install packages
//we need the package 'http' so we run this command to install- dart pub add http
//check pubspec for package changes
//note that our main function is async
void main(List<String> arguments) async{

// we need to add the word at the end of this URL
//check API docs on how to work with endpoints
var baseURL = 'https://api.dictionaryapi.dev/api/v2/entries/en/';

//prompt the user for valid word or exit command
while(true){
  print('Enter a word or type exit to quit');
  String? word = stdin.readLineSync();
  
  //validation to check if word was input
  if(word == null || word == ''){
    print('Please enter a word');
    continue; // start the loop again
  }
  
  if(word == 'exit'){
    print('quitting');
    break;
  }
  // form the endpoint
  var wordEndpoint = baseURL+word;
  
  //get the json body from our custom function
  var res = await getJson(wordEndpoint);

  //print(res)

  //validation to check if it was a bad response
  //start the prompt again
  if(res == false){
    print('Something is wrong. Please try again');
    continue;
  }
  
  //check if we have definition for the word
  if(res[0]['meanings'] != null){

    //debug or print the 'res' variable to see how it is formatted
    //this is important to extract the required data
    //here, we access multiple layers of the response
    //In this case, its formed as Maps and List items
    //If its a list, you can access it from the index
    //If its a map, you can access the key to get the value
    //further reading- https://dart.dev/language/collections

    var meanings = res[0]['meanings'][0]['definitions'][0]['definition'];
    
    //setup the table header and dashes
    var headerSpace = ' ' * ((word.length + 5) - 'Word'.length);
    var leftDashes = word.length;

    print('Word' + headerSpace + 'Definition'); //table headers
    print('-' * leftDashes + (' ' * 5) + '-' * meanings.length); //dashes

    // look up how to use padRight for Strings      
    print(word.padRight(word.length) + (' ' * 5) + meanings); //table data 

    // CHALLENGE: this version prints a new table everytime with only the current searched word
    // and previous results are lost.
    // try to find a way to store the previous word data 
    // and display each one after the other on the table
  }
  else{
    print('No definition found for this word: $word');
  }


}
}


//function to parse the endpoint and get the response
//this will throw exception if endpoint is not properly formatted
//returns a dynamic type based on the result of response
//this will return a Future if it succeeds
dynamic getJson(String endPoint) async{
  var url = Uri.parse(endPoint);
  var response = await http.get(url);

  //check status of request
  //if status returns a 200 OK then we proceed
  //otherwise, we return
  //you can debug the response variable to see what its returning 
  if(response.statusCode != 200){
    return false;
  }
  
  //use jsonDecode to get the body of the response
  var decodedJson = jsonDecode(response.body);
  return decodedJson;
}


// void getDogImage() async {
// var dogData = await getJson('https://dog.ceo/api/breeds/image/random');
// }

// void getDogBreeds() async {
// var dogData = await getJson('https://dog.ceo/api/breeds/list/all');
// print(dogData['message']['terrier'][1]);
// }
