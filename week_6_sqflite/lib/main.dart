import 'package:flutter/material.dart';
import 'package:week_6_sqflite/database_helper.dart';

// Create an app that takes input and saves a new user in the database
// It should create, read, update and delete users
void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserPage(),
    );
  }
}

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _dbHelper = DatabaseHelper(); //get instance of db helper
  
  //define controllers for our text fields
  final _nameController = TextEditingController(); 
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  List<Map<String, dynamic>> _users = []; //a list of map objects to hold each user entity
  int? _selectedUserId; // state variable to track user ID of the user that has been selected.

  @override
  void initState() {
    super.initState();
    //initialize the user list by getting all users from db
    _refreshUserList();
  }

// get all ysers from db and update view
  void _refreshUserList() async {
    final data = await _dbHelper.getUsers();
    setState((){
      _users = data;
    });
  }
  
  // formulate new user from input details
  void _addUser() async {
    //if text fields are empty then go back
    if(_nameController.text.isEmpty ||
    _addressController.text.isEmpty ||
    _phoneController.text.isEmpty){
      return;
    }
    //create the user entity as a map object
    final user = {
      'name' : _nameController.text,
      'address' : _addressController.text,
      'phone' : _phoneController.text,

    };
    
    //insert created user
    await _dbHelper.insertUser(user);
    //clear text fields
    _clearInputs();
    _refreshUserList();
  }
  
  void _updateUser() async {
    //check if user is selected
    //use the state variable to check
    if(_selectedUserId == null) return;

    // formulate user from input details
    // these are details to be updated
    final user = {
      'id': _selectedUserId,
      'name' : _nameController.text,
      'address' : _addressController.text,
      'phone' : _phoneController.text,

    };

    //update user
    await _dbHelper.updateUser(user);
    //clear text fields
     _clearInputs();
    _refreshUserList();


  }


  //pass down the id from button click on the list item
  void _deleteUser(int id) async {
    await _dbHelper.deleteUser(id);
    // clear input and refresh view
    _clearInputs();
    _refreshUserList();

  }

  // this will clear the text fields
  // and nullify the state variable so no ID will be selected
  void _clearInputs() {
    _nameController.clear();
    _addressController.clear();
    _phoneController.clear();
    _selectedUserId = null;

  }
  
  //when user taps on a dsiplayed user item on the UI, 
  //the  text fields will populate based on the user data
  void _populateFields(Map<String, dynamic> user) {
    _nameController.text = user['name'];
    _addressController.text= user['address'];
    _phoneController.text= user['phone'];
    _selectedUserId = user['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQFlite Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _addUser,
                  child: const Text('Add'),
                ),
                ElevatedButton(
                  onPressed: _updateUser,
                  child: const Text('Update'),
                ),
                ElevatedButton(
                  onPressed: _clearInputs,
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _users.isEmpty
                  ? const Center(child: Text('No users found.'))
                  : ListView.builder(
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        final user = _users[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(user['name']),
                            subtitle: Text(
                                'Address: ${user['address']}\nPhone: ${user['phone']}'),
                            onTap: () {
                              _populateFields(user);
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteUser(user['id']),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
