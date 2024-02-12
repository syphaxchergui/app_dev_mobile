import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tp_2/Screens/HomeScreen.dart';
import 'package:tp_2/Screens/LoginScreen.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  void updateLoginStatus(bool status) {
    print('Updating login status to: $status');
    setState(() {
      isLoggedIn = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIAGED',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: isLoggedIn
          ? HomeScreen(updateLoginStatus)
          : LoginPage(updateLoginStatus),
    );
  }
}
