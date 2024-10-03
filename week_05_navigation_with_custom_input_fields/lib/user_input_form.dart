import 'package:flutter/material.dart';

//3 custom input fields
// one stateless widget 
// one stateful
// one extending formfield

// The widget types used here to create custom text fields is just to show different approaches.
// When you are creating your apps, you can choose any widget type based on preference

// Custom stateless widget 
// default label is name
// but we can pass any label and use it as a custom text field
class NameField extends StatelessWidget {
  final TextEditingController controller;

  final String label;

  const NameField({
    super.key,
    required this.controller,
    this.label = 'Name',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          return null;
        },
      ),
    );
  }
}

//same thing but uses stateful
class WhatYouDoField extends StatefulWidget {
  final TextEditingController controller;

  final String label;

  const WhatYouDoField({
    super.key,
    required this.controller,
    this.label = 'What You Do',
  });

  @override
 // WhatYouDoFieldState createState() => WhatYouDoFieldState();
    WhatYouDoFieldState createState() {
        return WhatYouDoFieldState();
      }

}

class WhatYouDoFieldState extends State<WhatYouDoField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '${widget.label} is required';
          }
          return null;
        },
      ),
    );
  }
}

//here we are directly using the parent FormField class
class EmailFormField extends FormField<String> {
  final TextEditingController controller;

  final String label;

  EmailFormField({
    super.key,
    required this.controller,
    this.label = 'Email',
    super.onSaved,
    FormFieldValidator<String>? validator,
  }): 
        //the super here enables us to be able to use the methods/properties of parent FormField class
        // this is Flutter's way of saying we need to use some of the properties of FormField (initialValue, validator etc.)
        super(
          initialValue: controller.text,
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
          builder: (FormFieldState<String> field) {
            final _EmailFormFieldState state = field as _EmailFormFieldState;
            state._setController(controller);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: label,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorText: field.errorText,
                ),
                onChanged: (value) {
                  field.didChange(value);
                },
              ),
            );
          },
        );

  @override
  FormFieldState<String> createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends FormFieldState<String> {
  TextEditingController? _controller;

  void _setController(TextEditingController controller) {
    if (_controller != controller) {
      if (_controller != null) {
        _controller!.removeListener(_onControllerChanged);
      }
      _controller = controller;
      _controller!.addListener(_onControllerChanged);
    }
  }

  void _onControllerChanged() {
    if (_controller != null) {
      didChange(_controller!.text);
    }
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.removeListener(_onControllerChanged);
    }
    super.dispose();
  }
}

class UserInputForm extends StatefulWidget {
  final Widget submitButton;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController whatYouDoController;
  final TextEditingController emailController;

  const UserInputForm({
    required this.submitButton,
    required this.formKey,
    required this.nameController,
    required this.whatYouDoController,
    required this.emailController,
    super.key,
  });

  @override
  _UserInputFormState createState() => _UserInputFormState();
}

class _UserInputFormState extends State<UserInputForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          NameField(
            controller: widget.nameController,
          ),
          WhatYouDoField(
            controller: widget.whatYouDoController,
          ),
          EmailFormField(
            controller: widget.emailController,
          ),
          const SizedBox(height: 20),
          widget.submitButton, // pass in a button widget here
        ],
      ),
    );
  }
}
