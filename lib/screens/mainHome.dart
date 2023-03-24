import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/moduleHome.dart';
import 'package:flutter_application_1/screens/teacherScreen.dart';


class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen>
    with SingleTickerProviderStateMixin {
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
        title: Text('Main Home'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Manage'),
            Tab(text: 'Contact'),
            Tab(text: 'About'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Text('Student Home'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ModuleHome()));
                  },
                  child: Text('Course Modules'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeacherScreen()));
                  },
                  child: Text('Teacher Home'),
                ),
              ],
            ),
          ),
          ListView(
            children: [
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('123 Main St, Anytown USA'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('555-555-5555'),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('contact@myschool.edu'),
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
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Message',
                ),
                maxLines: 5,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text('Submit'),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
