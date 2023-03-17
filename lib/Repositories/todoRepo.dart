import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipies/models/todo.dart';

class RecipiesRepository {
  final CollectionReference ctseCollection =
      FirebaseFirestore.instance.collection('ctse');

  Future addRecipie(String title, String description, String ingredients) async {
    return await ctseCollection.add({
      "title": title,
      "description": description,
      "ingredients":ingredients,
    });
  }

  Future editRecipie(id,String title, String description, String ingredients) async {
    await ctseCollection.doc(id).update({
      "title": title,
      "description": description,
      "ingredients":ingredients,
    });
  }

  Future removeRecipie(id) async {
    await ctseCollection.doc(id).delete();
  }

  List<Recipies> recipiesList(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Recipies(
        description: e.get("description"),
        ingredients: e.get("ingredients"),
        title: e.get("title"),
        id: e.id,
      );
    }).toList();
  }

  Stream<List<Recipies>> listRecipies() {
    return ctseCollection.snapshots().map(recipiesList);
  }
}
