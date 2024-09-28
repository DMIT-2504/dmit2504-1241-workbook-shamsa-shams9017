import 'package:flutter/material.dart';


class TextFormFieldStateful extends StatefulWidget{
  @override
  _TextFormFieldState createState() => _TextFormFieldState();
}

//state class for text form field
class _TextFormFieldState extends State<TextFormFieldStateful>{

  //key to manage the state of formfield

  final _key = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  //focus nodes for managing focus betweeen fields
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNodes = FocusNode();
  
  @override
  void dispose(){
    super.dispose(); //must dispose the super class states as well
    // dispose controllers and focusnodes to prevent memory leaks
    nameController.dispose();
    emailController.dispose();
    nameFocusNode.dispose();
    emailFocusNodes.dispose();
  }

    @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _key,// pass in key to manage state
        autovalidateMode: AutovalidateMode.onUserInteraction, //this validates automatically on user interaction
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(height: 100),

          //name field
          TextFormField(
          controller: nameController,
          focusNode: nameFocusNode,
          decoration: InputDecoration(
            labelText: 'Enter name',
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 14
            ) // display error message for name
          ),
          validator: (value){
            if(value == null || value.isEmpty){
              return 'Name cannot be empty';
            }
          },
         
        ),
         SizedBox(height: 20),
         //email text form field
         TextFormField(
          controller: emailController,
          focusNode: emailFocusNodes,
          decoration: InputDecoration(
            labelText: 'Enter email',
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 14
            ) // display error message for name
          ),
          validator: (value){
            if(value == null || value.isEmpty){
              return 'email cannot be empty';
            }
          },
         
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            //get data from controller
            String name = nameController.text;
            String email = emailController.text;
           if(_key.currentState!.validate()){
             ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Form submitted. Your name is $name and your email is $email')
                  )
                );
           }
          }, child: Text('Submit'),
        ),
        SizedBox(height: 20),
        TextButton(
          child: Text('Reset Form'),
          onPressed: (){
            _key.currentState!.reset();
            nameController.clear();
            emailController.clear();

          }
        )

          ]
        )
      )

    );
  }
  }


