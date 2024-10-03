
import 'package:flutter/material.dart';
import 'package:week_05_navigation_with_custom_input_fields/user_input_form.dart';

//Page 2 will receive the data from Page 1
// we are getting the data using constructor parameters of the Page2 class.

class PageTwo extends StatefulWidget {
  final String name;
  final String whatYouDo;
  final String email;

  const PageTwo({
    super.key,
    this.name = '',
    this.whatYouDo = '',
    this.email = '',
  });

  @override
  PageTwoState createState() => PageTwoState();
}

class PageTwoState extends State<PageTwo> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _whatYouDoController;
  late TextEditingController _emailController;

  @override
  //we will get the data passed from Page 1 here
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _whatYouDoController = TextEditingController(text: widget.whatYouDo);
    _emailController = TextEditingController(text: widget.email);

// Using addPostFrameCallback() ensures  Page 2 has been fully built 
// before trying to access the Scaffold, 
// allowing you to safely show the SnackBar.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Page 1 Data: Name: ${widget.name}, What You Do: ${widget.whatYouDo}, Email: ${widget.email}',
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _whatYouDoController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Page 2'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Reusable form
        child: UserInputForm(
          formKey: _formKey,
          nameController: _nameController,
          whatYouDoController: _whatYouDoController,
          emailController: _emailController,
          submitButton: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                //go back to Page 1 and pass data from Page 2
                Navigator.pop(
                  context,
                  {
                    'name': _nameController.text,
                    'whatYouDo': _whatYouDoController.text,
                    'email': _emailController.text,
                  },
                );
              }
            },
            child: const Text('Submit'),
          ),
        ),
      ),
    );
  }
}
