import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/mainHome.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/login.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginScreen()
          : MainHomeScreen(),
    );
  }
}

