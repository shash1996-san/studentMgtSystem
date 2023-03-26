import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/teacher.dart';

class TeacherRepository {
  //create collection
  final CollectionReference ctseCollection =
      FirebaseFirestore.instance.collection('teachers');

  //add teacher records
  Future addTeacher(
      String name, String phone, String email, String researchArea) async {
    return await ctseCollection.add({
      "name": name,
      "phone": phone,
      "email": email,
      "researchArea": researchArea
    });
  }

  //edit teacher records
  Future editTeacher(
      id, String name, String phone, String email, String researchArea) async {
    await ctseCollection.doc(id).update({
      "id": id,
      "name": name,
      "phone": phone,
      "email": email,
      "researchArea": researchArea
    });
  }

  //remove teachers
  Future removeTeacher(id) async {
    await ctseCollection.doc(id).delete();
  }

  //retrieve teacher lists
  List<Teacher> TeachersList(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Teacher(
        researchArea: e.get("researchArea"),
        email: e.get("email"),
        phone: e.get("phone"),
        name: e.get("name"),
        id: e.id,
      );
    }).toList();
  }

  Stream<List<Teacher>> listTeachers() {
    return ctseCollection.snapshots().map(TeachersList);
  }
}
