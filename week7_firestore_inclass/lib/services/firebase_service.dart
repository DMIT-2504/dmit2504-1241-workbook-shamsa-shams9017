import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:week7_firestore_inclass/models/todo.dart';

// all firebase operations are done in this class
class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUp(String email, String password, String firstName, String lastName) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final uid = userCredential.user?.uid;

    if (uid != null) {
      final userCollection = _firestore.collection('users'); // get collection itself called 'users'

      //assign same ID to the user document in collection
      await userCollection.doc(uid).set({
        'firstName': firstName,
        'lastName': lastName,
      });
    }
    return userCredential.user;
  }

  Future<User?> signIn(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }
  
  // CRUD operations
  //Read todos
  Future<List<Todo>> fetchTodos(String userId) async {
    // get subcollection using the same method
    // will return an empty snapshot if it does not exist
    // snapshot is the data at the time when the query was being executed
    final snapshot = await _firestore.collection('users').doc(userId).collection('todoList').get();

    // snapshot.docs is a list of QueryDocumentSnapshot objects, where each item represents a document in Firestore that matches the query.
    // These documents contain the raw data retrieved from Firestore.  
    return snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList();
  }
  
  //create todo
  Future<void> addTodo(String userId, Todo todo) async {
    //a newly created user will not have a todoist
    // once the following add method runs, the todoList colection will be created for that user
    final todosCollection = _firestore.collection('users').doc(userId).collection('todoList');
    await todosCollection.add(todo.toMap()); // use add method after getting the collection
  }

// Update
  Future<void> updateTodo(String userId, Todo todo) async {
    final todosCollection = _firestore.collection('users').doc(userId).collection('todoList');
    await todosCollection.doc(todo.id).update(todo.toMap());
  }

  // this is how you can add where clause in code -
  // final todosCollection = _firestore
  //   .collection('users')
  //   .doc(userId)
  //   .collection('todoList')
  //   .where('completed', isEqualTo: false);

 // Delete
  Future<void> deleteTodo(String userId, String todoId) async {
    final todosCollection = _firestore.collection('users').doc(userId).collection('todoList');
    await todosCollection.doc(todoId).delete();
  }
}
