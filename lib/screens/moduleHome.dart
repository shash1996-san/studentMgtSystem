// ignore_for_file: dead_code

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loader.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/screens/moduleNotices.dart';
import "../models/module.dart";
import '../Repositories/moduleRepository.dart';

class ModuleHome extends StatefulWidget {
  const ModuleHome({super.key});

  @override
  _ModuleHomeState createState() => _ModuleHomeState();
}

class _ModuleHomeState extends State<ModuleHome> {
  TextEditingController moduleNameController = TextEditingController();
  TextEditingController moduleDurationController = TextEditingController();
  TextEditingController moduleDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Management App"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text("Confirmation Required"),
                      content: const Text("Are you sure to log out?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return const LoginScreen();
                            }));
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<List<Module>>(
            stream: ModuleRepository().listModule(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Loader();
              }
              List<Module>? listModule = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "All Modules",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      color: Colors.grey[600],
                    ),
                    const SizedBox(height: 20),
                    ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey[600],
                      ),
                      shrinkWrap: true,
                      itemCount: listModule!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () => {
                            showDialog(
                              builder: (context) => SimpleDialog(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 20,
                                ),
                                backgroundColor: Colors.grey[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Row(
                                  children: [
                                    const Text(
                                      "Update Module",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    )
                                  ],
                                ),
                                children: [
                                  const Divider(),
                                  TextFormField(
                                    controller: moduleNameController,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      height: 1.5,
                                      color: Colors.white,
                                    ),
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                      hintText: "Type module name here",
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: moduleDurationController,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      height: 1.5,
                                      color: Colors.white,
                                    ),
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                      hintText: "Type module duration here",
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: moduleDescriptionController,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      height: 1.5,
                                      color: Colors.white,
                                    ),
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                      hintText: "Type module description here",
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: width,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (moduleNameController
                                            .text.isNotEmpty) {
                                          await ModuleRepository().editModule(
                                              listModule[index].moduleId,
                                              moduleNameController.text.trim(),
                                              moduleDurationController.text
                                                  .trim(),
                                              moduleDescriptionController.text
                                                  .trim());
                                          // ignore: use_build_context_synchronously
                                          Navigator.pop(context);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                        minimumSize: const Size(60, 60),
                                        elevation: 10,
                                      ),
                                      child: const Text("Update"),
                                    ),
                                  )
                                ],
                              ),
                              context: context,
                            ),
                          },
                          
                          title: Text(
                            listModule[index].moduleName,
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listModule[index].moduleDuration,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                listModule[index].moduleDescription,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          trailing: TextButton(
                            onPressed: () async {
                              bool confirmDelete = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Confirm Deletion"),
                                    content: const Text(
                                        "Are you sure you want to delete this module?"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("Cancel"),
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("Delete"),
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirmDelete == true) {
                                await ModuleRepository()
                                    .removeModule(listModule[index].moduleId);
                              }
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              showDialog(
                builder: (context) => SimpleDialog(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ),
                  backgroundColor: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Row(
                    children: [
                      const Text(
                        "Add Module",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.grey,
                          size: 30,
                        ),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                  children: [
                    const Divider(),
                    TextFormField(
                      controller: moduleNameController,
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.5,
                        color: Colors.white,
                      ),
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "Type module name here",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                    TextFormField(
                      controller: moduleDurationController,
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.5,
                        color: Colors.white,
                      ),
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "Type module code here",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                    TextFormField(
                      controller: moduleDescriptionController,
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.5,
                        color: Colors.white,
                      ),
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "Type module description here",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: width,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (moduleNameController.text.isNotEmpty) {
                            await ModuleRepository().addModule(
                                moduleNameController.text.trim(),
                                moduleDurationController.text.trim(),
                                moduleDescriptionController.text.trim());
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          minimumSize: const Size(60, 60),
                          elevation: 10,
                        ),
                        child: const Text("Add"),
                      ),
                    )
                  ],
                ),
                context: context,
              );
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.orange,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ModuleNotices()));
            },
            child: const Icon(Icons.notifications_active),
          ),
        ],
      ),
    );
  }
}
