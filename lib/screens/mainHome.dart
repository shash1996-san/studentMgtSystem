import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loader.dart';
import 'package:flutter_application_1/screens/login.dart';
import '../Repositories/contactRepo.dart';
import "../models/contact.dart";

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen>
  with TickerProviderStateMixin {
  TextEditingController NameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController MessageController = TextEditingController();
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<Offset> _animation;

   @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

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
          AnimatedSwitcher(
            duration: Duration(seconds:4 ),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: Container(
              key: ValueKey<int>(0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/img.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home()));
                      },
                      child: Text('Student Home'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home()));
                      },
                      child: Text('Component 2'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home()));
                      },
                      child: Text('Component 3'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: ListView(
              key: ValueKey<int>(1),
            children: [
              
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('123 Main St, Gampaha SriLanka'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('505-565-3445'),
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
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MainHomeScreen()));
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
          ),
      Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/book.jpg'),
      fit: BoxFit.cover,
    ),
  ),
  child: Padding(
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
)

        ],
      ),
    );
  }
}
