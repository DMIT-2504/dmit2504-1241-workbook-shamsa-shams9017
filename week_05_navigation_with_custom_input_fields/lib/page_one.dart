
import 'package:flutter/material.dart';
import 'package:week_05_navigation_with_custom_input_fields/page_two.dart';
import 'package:week_05_navigation_with_custom_input_fields/user_input_form.dart';

// we are passing data using constructor parameters of the PageTwo class.
// This is a common and straightforward approach to pass data
// There are other approaches to pass data between pages such as using Routesettings.
// Uncomment the other approaches to see them in action

// The data is passed when Page 2 is loaded,
// and it is accessible through the constructor's parameters.

// Navigator.push() is always a Future
// Navigator.push() is used to add a route to the navigation stack,
// which effectively means opening a new page in your Flutter app.
// Since Flutter navigation is asynchronous,
// (it involves animations and waiting for the user to finish interacting with the new page),
// the result of Navigator.push() is wrapped in a Future.
// The Future returned by Navigator.push() completes when the pushed route is popped
// (i.e., when the user navigates back to the previous page).

// using .then (dot then) means the app is waiting for that future to complete
// and executing some code after the user returns to the original page.

class PageOne extends StatelessWidget {
  PageOne({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _whatYouDoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

// FormKey is used to uniquely identify a Form widget and its state. 
// In Flutter, you can't directly interact with the 
// internal state of a Form widget through a simple reference so you use a key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Page 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: UserInputForm(
          submitButton: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageTwo(
                      name: _nameController.text,
                      whatYouDo: _whatYouDoController.text,
                      email: _emailController.text,
                    ),
                  ),
                ).then((result) {
                  if (result != null && result is Map<String, String>) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Page 2 Data: Name: ${result['name']}, What You Do: ${result['whatYouDo']}, Email: ${result['email']}',
                        ),
                      ),
                    );
                  }
                });
                //Approach 2: Use named routes to pass data
                // Navigator.pushNamed(
                //   context,
                //   '/page2',
                //   arguments: {
                //     'name': _nameController.text,
                //     'whatYouDo': _whatYouDoController.text,
                //     'email': _emailController.text,
                //   },
                // ).then((result) {
                //   if (result != null && result is Map<String, String>) {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(
                //         content: Text(
                //           'Page 2 Data: Name: ${result['name']}, What You Do: ${result['whatYouDo']}, Email: ${result['email']}',
                //         ),
                //       ),
                //     );
                //   }
                // });
              }
              // Approach 3: Use routesettings
              //Routesettings pushnamed example
              //Note that here, routesettings is being used under the hood
              // Navigator.pushNamed(
              //   context,
              //   '/page2',
              //   arguments: {
              //     'name': _nameController.text,
              //     'whatYouDo': _whatYouDoController.text,
              //     'email': _emailController.text,
              //   },
              // ).then((result) {
              //   if (result != null && result is Map<String, String>) {
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       SnackBar(
              //         content: Text(
              //           'Page 2 Data: Name: ${result['name']}, What You Do: ${result['whatYouDo']}, Email: ${result['email']}',
              //         ),
              //       ),
              //     );
              //   }
              // });
            },
            child: const Text('Submit'),
          ),
          nameController: _nameController,
          whatYouDoController: _whatYouDoController,
          emailController: _emailController,
          formKey: _formKey,
        ),
      ),
    );
  }
}
