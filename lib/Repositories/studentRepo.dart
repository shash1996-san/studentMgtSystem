import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/student.dart';

class StudentRepository {
  final CollectionReference ctseCollection =
      FirebaseFirestore.instance.collection('ctse');

  Future addStudent(String stid, String grade, String subject, String mark) async {
    return await ctseCollection.add({
      "stid":  stid,
      "grade": grade,
      "subject":subject,
      "mark":mark,
    });
  }

  Future editStudent(id,String stid,String grade, String subject, String mark) async {
    await ctseCollection.doc(id).update({
       "stid":  stid,
       "grade": grade,
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
        stid: e.get("stid"),
        subject: e.get("subject"),
        mark: e.get("mark"),
        grade: e.get("grade"),
        id: e.id,
      );
    }).toList();
  }

  Stream<List<Student>> listStudents() {
    return ctseCollection.snapshots().map(StudentsList);
  }
}
