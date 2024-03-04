import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tp_2/Screens/HomeScreen.dart';
import 'package:tp_2/Screens/LoginScreen.dart';
import 'package:tp_2/Screens/SignupScreen.dart';
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
  bool isInscriptionPage = false;

  void updateLoginStatus(bool status) {
    print('Updating login status to: $status');
    setState(() {
      isLoggedIn = status;
      isInscriptionPage = false;
    });
  }

  void updateInscriptionPage(bool status) {
    print('Updating inscription page status to: $status');
    setState(() {
      isInscriptionPage = status;
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
          : isInscriptionPage
              ? SignUpPage(updateLoginStatus, updateInscriptionPage)
              : LoginPage(updateLoginStatus, updateInscriptionPage),
    );
  }
}
