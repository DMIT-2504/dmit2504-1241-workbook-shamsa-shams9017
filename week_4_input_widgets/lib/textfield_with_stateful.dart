import 'package:flutter/material.dart';


class SimpleTextFieldStateful extends StatefulWidget{
  @override
  _SimpleTextFieldState createState() => _SimpleTextFieldState();
}

//state class to display error messages
class _SimpleTextFieldState extends State<SimpleTextFieldStateful>{

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  
  // variables for validation errors
  String? nameError;
  String? emailError;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        SizedBox(height: 100),
        //name textfield
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Enter name',
            errorText: nameError // display error message for name
          ),
          onChanged: (text){
            setState(() {
              if(text.isEmpty){
                nameError = 'Name cannot be empty';
              }else{
                nameError = null;
              }
            }
            );
          },
        ),
        SizedBox(height: 20),
        //email
         TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Enter email',
            errorText: emailError // display error message for name
          ),
          onChanged: (text){
            setState(() {
              if(text.isEmpty){
                emailError = 'Email cannot be empty';
              }else{
                emailError = null;
              }
            }
            );
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            //get data from controller
            String name = nameController.text;
            String email = emailController.text;

            setState(() {
              if(name.isEmpty){
                nameError = 'Name cannot be empty';
              }
              else{
                nameError = null;
              }

              if(email.isEmpty){
                emailError = 'Email cannot be empty';
              }
              else{
                emailError = null;
              }

              if(nameError == null && emailError == null){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Form submitted. Your name is $name and your email is $email')
                  )
                );
              }
            });


          }, child: Text('Submit'),
        )
 
      ]
      ) 

    );
  }
}