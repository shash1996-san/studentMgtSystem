import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/student.dart';

class ContactRepository {
  final CollectionReference contactCollection =
      FirebaseFirestore.instance.collection('contact');

  Future addContact( String name, String email, String message) async {
    return await contactCollection.add({
     
      "name": name,
      "email":email,
      "message":message,
    });
  }

  



 
}
