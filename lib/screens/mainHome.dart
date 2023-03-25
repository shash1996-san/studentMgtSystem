import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';

import 'package:flutter_application_1/screens/moduleHome.dart';
import 'package:flutter_application_1/screens/teacherScreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loader.dart';
import 'package:flutter_application_1/screens/login.dart';
import '../Repositories/contactRepo.dart';
import "../models/contact.dart";


class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController NameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController MessageController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('Main Home'),

        title: Text('Home'),
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

        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Manage'),
            Tab(text: 'Contact'),
            Tab(text: 'About'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              children: [
                const SizedBox(height: 16),
                Container(
                  width: 200,
                  height: 190,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'lib/assets/student.png',
                          height: 70,
                          width: 70,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Student Home',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 200,
                  height: 190,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ModuleHome()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'lib/assets/module.png',
                          height: 70,
                          width: 70,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Course Modules',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 200,
                  height: 190,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TeacherScreen()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'lib/assets/teacher.png',
                          height: 70,
                          width: 70,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Teacher Home',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              children: [
                const ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('123 Main St, Anytown USA'),
                ),
                const ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('555-555-5555'),
                ),
                const ListTile(
                  leading: Icon(Icons.email),
                  title: Text('contact@myschool.edu'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Get in touch with us',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Message',
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Submit'),
                ),
              ],
            ),

          ListView(
            children: [
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('123 Main St, Gampaha SriLanka'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('555-555-5555'),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('contact@stdmgt.edu'),
              ),
              SizedBox(height: 16),
              Text(
                'Get in touch with us',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: NameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                controller: EmailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: MessageController,
                decoration: InputDecoration(
                  labelText: 'Message',
                ),
                maxLines: 5,
              ),
              SizedBox(height: 16),
             ElevatedButton(
  onPressed: () async {
    if (NameController.text.isNotEmpty) {
      await ContactRepository().addContact(
          NameController.text.trim(),
          EmailController.text.trim(),
          MessageController.text.trim());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Inquiry successfully submitted'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainHomeScreen()));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  },
  child: Text('Submit'),
),

            ],

          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Student Management System',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'The Student Management System is a software application designed to manage and organize student-related data such as enrollment, academic records, grades, and personal information. It provides a centralized database that facilitates the storage, retrieval, and analysis of this data, helping educational institutions to streamline their administrative processes and improve their overall efficiency.',
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
