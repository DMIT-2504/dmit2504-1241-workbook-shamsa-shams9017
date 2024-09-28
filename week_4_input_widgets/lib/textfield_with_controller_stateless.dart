

import 'package:flutter/material.dart';

class SimpleTextFieldController extends StatelessWidget{

//instantiate controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  SimpleTextFieldController({super.key});

@override
Widget build(BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // name textfield
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Enter your name'
          )
        ),
        SizedBox(height: 20), //space between
        //email textfield 
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Enter your email'
          )
        ),
        SizedBox(height: 20), //space between

        ElevatedButton(
          onPressed: () {
            //get data from controller
            String name = nameController.text;
            String email = emailController.text;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Yout name is $name and your email is $email')
              )
            );
          }, child: Text('Submit'),
        )
 
        
      ]
    )
  );
}
}