import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  static Future<void> addEntry1(
    String firstName,
    String lastName,
    String birthDay,
    String email,
    
  ) async {
    await FirebaseFirestore.instance.collection("users").doc().set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dateOfBirth': birthDay,
    });
  }
}
