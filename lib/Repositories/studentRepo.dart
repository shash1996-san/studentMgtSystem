/**References  Github,Flutter documentation,Youtube,Stackoverflow,Flutterappworld.com,Firebase.com */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/student.dart';

class StudentRepository {
  final CollectionReference ctseCollection =
      FirebaseFirestore.instance.collection('ctse');

  Future addStudent( String name, String subject, String mark) async {
    return await ctseCollection.add({
     
      "name": name,
      "subject":subject,
      "mark":mark,
    });
  }

  Future editStudent(id,String name, String subject, String mark) async {
    await ctseCollection.doc(id).update({
       "id":  id,
       "name": name,
       "subject": subject,
       "mark":mark,
    });
  }

  Future removeStudent(id) async {
    await ctseCollection.doc(id).delete();
  }

  List<Student> StudentsList(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Student(
        subject: e.get("subject"),
        mark: e.get("mark"),
        name: e.get("name"),
        id: e.id,
      );
    }).toList();
  }

  Stream<List<Student>> listStudents() {
    return ctseCollection.snapshots().map(StudentsList);
  }
}
