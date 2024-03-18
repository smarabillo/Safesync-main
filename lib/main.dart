import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safesync/pages/login_screen.dart'; // Import the LoginScreen widget
import 'package:safesync/pages/splashscreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  )); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safesync',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.indigo,
      ),
      home: SplashScreen(), // Set the LoginScreen as the home page
    );
  }
}