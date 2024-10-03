import 'package:flutter/material.dart';

// The widget types used here to create custom text fields is just to show different approaches.
// When you are creating your apps, you can choose any widget type based on preference

//Stateless
class NameField extends StatelessWidget{
  final TextEditingController controller;
  final String label;
  //note here that we have used a default label called 'Name'
  //If you want to use a different label, just pass the name of the label when creating the constructor
  NameField({super.key, required this.controller, this.label = 'Name'});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0)
          )
        ),
        validator: (value){
          if(value == null || value.isEmpty){
            return 'Please enter a $label';
          }
          return null;
        },
      )
    );
  }
}


//Stateful
class WhatYouDoField extends StatefulWidget{
  final TextEditingController controller;
  final String label;

  WhatYouDoField({super.key, required this.controller, this.label = 'What You Do'});

  @override
  WhatYouDoFieldState createState(){
    return WhatYouDoFieldState();
  } 
}

class WhatYouDoFieldState extends State<WhatYouDoField>{

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          labelText: widget.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0)
          )
        ),
        validator: (value){
          if(value == null || value.isEmpty){
            return 'Please enter $widget.label';
          }
          return null;
        },
      )
    );
  }
}

//here we are directly using the parent FormField class
class EmailFormField extends FormField<String>{
  final TextEditingController controller;
  final String label;

  EmailFormField({super.key, required this.controller, this.label = 'Email'})
  //the super here is used to be able to use the methods/properties of parent FormField class
  // this is Flutter's way of saying we need to use some of the properties of FormField (initialValue, validator etc.)
  : super(
    initialValue: controller.text,
    validator: (value){
      if(value == null || value.isEmpty){
        return 'Email is required';
      }
      //below we are validating the format of the email using regular expressions
      //The RegExp class accepts regular expressions tocheck on what format the user input is in
      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
        return 'Enter a valid email';
      }

      return null;
    },
    builder: (FormFieldState<String> field){
      final EmailFormFieldState state = field as EmailFormFieldState;
      state._setController(controller);
      return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0)
          )
        ),
        validator: (value){
          if(value == null || value.isEmpty){
            return 'Please enter $label';
          }
          return null;
        },
      )
    );
    }
  );

  @override
  FormFieldState<String> createState() => EmailFormFieldState();
}


class EmailFormFieldState extends FormFieldState<String>{
  TextEditingController? _controller;

  void _setController(TextEditingController controller){
    if(_controller != controller){
      if(_controller != null){
        _controller!.removeListener(_onControllerChanged);
      }
      _controller = controller;
      _controller!.addListener(_onControllerChanged);
    }

  }

  void _onControllerChanged(){
    didChange(_controller!.text);
  }

  @override
  void dispose(){
    if(_controller != null){
      _controller!.removeListener(_onControllerChanged);
    }

  super.dispose();
  }

}


class UserInputForm extends StatefulWidget {
  final Widget submitButton;
  final GlobalKey<FormState> formKey;
  TextEditingController nameController;
  TextEditingController whatYouDoController;
    TextEditingController emailController;

UserInputForm(
  {
    required this.submitButton,
    required this.formKey,
    required this.nameController,
        required this.whatYouDoController,
            required this.emailController,
            super.key

  }
);

@override
UserInputFormState createState() => UserInputFormState();

}


class UserInputFormState extends State<UserInputForm>{
  @override
  Widget build(BuildContext context){
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          NameField(controller: widget.nameController),
          WhatYouDoField(controller: widget.whatYouDoController),
          EmailFormField(controller: widget.emailController),
          SizedBox(height: 20),
          widget.submitButton
        ]
      )
    );
  }
}