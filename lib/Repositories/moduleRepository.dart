import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/module.dart';

class ModuleRepository {
  final CollectionReference moduleCollection =
      FirebaseFirestore.instance.collection('module');

  Future addModule(String moduleName, String moduleDuration,
      String moduleDescription) async {
    return await moduleCollection.add({
      "moduleName": moduleName,
      "moduleDuration": moduleDuration,
      "moduleDescription": moduleDescription,
    });
  }

  Future editModule(moduleId, String moduleName, String moduleDuration,
      String moduleDescription) async {
    await moduleCollection.doc(moduleId).update({
      "moduleId": moduleId,
      "moduleName": moduleName,
      "moduleDuration": moduleDuration,
      "moduleDescription": moduleDescription,
    });
  }

  Future removeModule(moduleId) async {
    await moduleCollection.doc(moduleId).delete();
  }

  List<Module> ModuleList(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Module(
        moduleDescription: e.get("moduleDescription"),
        moduleDuration: e.get("moduleDuration"),
        moduleName: e.get("moduleName"),
        moduleId: e.id,
      );
    }).toList();
  }

  Stream<List<Module>> listModule() {
    return moduleCollection.snapshots().map(ModuleList);
  }
}
