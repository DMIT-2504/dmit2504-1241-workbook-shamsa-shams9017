import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.firstName,
    required this.lastName,
    required this.uid,
  });

  String firstName;
  String lastName;
  String uid;

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return UserModel(
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      uid: snapshot.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
