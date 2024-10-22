import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  Todo({
    required this.description,
    required this.completed,
    this.id,
  });

  String description;
  bool completed;
  String? id;
  
  // the fromFirestore factory constructor is creating a Todo object from 
  // the data coming from a Firestore DocumentSnapshot.
  // factory constructor is preferable because you're transforming data 
  // from an external source like Firestore, and you want to apply additional logic or validation.

  factory Todo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    // This extracts the data from the Firestore DocumentSnapshot. 
    // The data() method returns a map of the document's field data, with each field as a key-value pair.
    final data = snapshot.data();
    return Todo(
      description: data?['description'],
      completed: data?['completed'],
      // Capture the document id for the todo id
      id: snapshot.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'completed': completed,
    };
  }
}