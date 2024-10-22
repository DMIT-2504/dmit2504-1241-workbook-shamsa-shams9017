import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:week7_firestore_inclass/models/todo.dart';
import 'package:week7_firestore_inclass/pages/auth_page.dart';
import 'package:week7_firestore_inclass/services/firebase_service.dart';


class TodoPage extends StatefulWidget {
  final User user;

  TodoPage({required this.user});

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final FirebaseService _firebaseService = FirebaseService(); 
  final TextEditingController _todoController = TextEditingController();
  List<Todo> _todos = [];

  void _fetchTodos() async {
    final todos = await _firebaseService.fetchTodos(widget.user.uid);
    setState(() {
      _todos = todos;
    });
  }

  void _addTodo() async {
    if (_todoController.text.isNotEmpty) {
      await _firebaseService.addTodo(
        widget.user.uid,
        Todo(description: _todoController.text, completed: false),
      );
      _todoController.clear();
      _fetchTodos();
    }
  }

  void _deleteTodo(String todoId) async {
    await _firebaseService.deleteTodo(widget.user.uid, todoId);
    _fetchTodos();
  }

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthPage()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _todoController,
            decoration: InputDecoration(labelText: 'New Todo'),
          ),
          ElevatedButton(
            onPressed: _addTodo,
            child: Text('Add Todo'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  title: Text(todo.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: todo.completed,
                        onChanged: (value) {
                          setState(() {
                            todo.completed = value!;
                            _firebaseService.updateTodo(widget.user.uid, todo);
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteTodo(todo.id!);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
