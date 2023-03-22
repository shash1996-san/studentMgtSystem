// ignore_for_file: dead_code

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loader.dart';
import 'package:flutter_application_1/screens/login.dart';
import '../Repositories/studentRepo.dart';
import "../models/student.dart";

import 'package:flutter_application_1/models/student.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController studentNameController = TextEditingController();
  TextEditingController studentSubject = TextEditingController();
  TextEditingController studentMark = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text("Confirmation Required"),
                      content: const Text("Are you sure to log out? "),
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
        child: StreamBuilder<List<Student>>(
            stream: StudentRepository().listStudents(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Loader();
              }
              List<Student>? listStudents = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "All Students",
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
                      itemCount: listStudents!.length,
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
                    "Add Task",
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
                  controller: studentNameController,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "type your Name here",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
          
                TextFormField(
                  controller: studentSubject,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "type your subject here",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),

                TextFormField(
                  controller: studentMark,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "type your Mark here",
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
                      if (studentNameController.text.isNotEmpty) {
                        await StudentRepository()
                            .editStudent(listStudents[index].id,studentNameController.text.trim(),studentSubject.text.trim(),studentMark.text.trim());
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
          ),
                          },
                          leading: Text(
                            listStudents[index].name,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                            
                          ),
                          title:Text(
                                  listStudents[index].subject +' '+ listStudents[index].mark,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                          
                          trailing: TextButton(
                            onPressed: () async {
                              await StudentRepository()
                                  .removeStudent(listStudents[index].id);
                            },
                            child: const Icon(Icons.delete),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
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
                    "Add Task",
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
                  controller: studentNameController,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "type your Name here",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
           
                TextFormField(
                  controller: studentSubject,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "type your subject here",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),

                TextFormField(
                  controller: studentMark,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "type your Mark here",
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
                      if (studentNameController.text.isNotEmpty) {
                        await StudentRepository()
                            .addStudent(studentNameController.text.trim(),studentMark.text.trim(),studentSubject.text.trim());
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
    );
  }
}
