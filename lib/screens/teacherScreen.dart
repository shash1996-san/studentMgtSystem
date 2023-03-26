import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loader.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/screens/teacherNotices.dart';
import '../Repositories/teacherRepo.dart';
import 'package:flutter_application_1/models/teacher.dart';

//teacher screen
class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  //create state
  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  TextEditingController teacherNameController = TextEditingController();
  TextEditingController teacherPhone = TextEditingController();
  TextEditingController teacherEmail = TextEditingController();
  TextEditingController teacherResearchArea = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //header
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
          //teacher list
          child: StreamBuilder<List<Teacher>>(
              stream: TeacherRepository().listTeachers(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Loader();
                }
                List<Teacher>? listTeachers = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "All Teachers",
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
                        itemCount: listTeachers!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () => {
                              showDialog(
                                //update teachers dialog box
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
                                        "Update Teacher",
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

                                    //for teacher name
                                    TextFormField(
                                      controller: teacherNameController,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        height: 1.5,
                                        color: Colors.white,
                                      ),
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                        hintText: "Type teacher name here",
                                        hintStyle:
                                            TextStyle(color: Colors.white70),
                                        border: InputBorder.none,
                                      ),
                                    ),

                                    //for teacher phone number
                                    TextFormField(
                                      controller: teacherPhone,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        height: 1.5,
                                        color: Colors.white,
                                      ),
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                        hintText: "Type teacher phone here",
                                        hintStyle:
                                            TextStyle(color: Colors.white70),
                                        border: InputBorder.none,
                                      ),
                                    ),

                                    //for teacher email
                                    TextFormField(
                                      controller: teacherEmail,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        height: 1.5,
                                        color: Colors.white,
                                      ),
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                        hintText: "Type teacher email here",
                                        hintStyle:
                                            TextStyle(color: Colors.white70),
                                        border: InputBorder.none,
                                      ),
                                    ),

                                    //for teacher research area
                                    TextFormField(
                                      controller: teacherResearchArea,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        height: 1.5,
                                        color: Colors.white,
                                      ),
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                        hintText:
                                            "Type teacher research area here",
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
                                          if (teacherNameController
                                              .text.isNotEmpty) {
                                            await TeacherRepository()
                                                .editTeacher(
                                                    listTeachers[index].id,
                                                    teacherNameController.text
                                                        .trim(),
                                                    teacherPhone.text.trim(),
                                                    teacherEmail.text.trim(),
                                                    teacherResearchArea.text
                                                        .trim());
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
                              listTeachers[index].name,
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
                                  listTeachers[index].phone,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  listTeachers[index].email,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  listTeachers[index].researchArea,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            trailing: TextButton(
                              //delete button
                              onPressed: () async {
                                bool confirmDelete = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Confirm Deletion"),
                                      content: const Text(
                                          "Are you sure you want to delete this record?"),
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
                                  await TeacherRepository()
                                      .removeTeacher(listTeachers[index].id);
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
        //floating button to add teacher
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
                          "Add Teachers",
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
                      //for teacher name
                      TextFormField(
                        controller: teacherNameController,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.5,
                          color: Colors.white,
                        ),
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: "Type teacher name here",
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),

                      //for teacher phone number
                      TextFormField(
                        controller: teacherPhone,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.5,
                          color: Colors.white,
                        ),
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: "Type teacher phone here",
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),

                      //for teacher email
                      TextFormField(
                        controller: teacherEmail,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.5,
                          color: Colors.white,
                        ),
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: "Type teacher email here",
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),

                      //for teacher research area
                      TextFormField(
                        controller: teacherResearchArea,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.5,
                          color: Colors.white,
                        ),
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: "Type teacher research area here",
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
                            if (teacherNameController.text.isNotEmpty) {
                              await TeacherRepository().addTeacher(
                                  teacherNameController.text.trim(),
                                  teacherPhone.text.trim(),
                                  teacherEmail.text.trim(),
                                  teacherResearchArea.text.trim());
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
                    MaterialPageRoute(builder: (context) => TeacherNotices()));
              },
              child: const Icon(Icons.notifications_active),
            ),
          ],
        ));
  }
}
