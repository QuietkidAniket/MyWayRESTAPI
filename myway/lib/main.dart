import 'dart:async';
import 'package:flutter/material.dart';
import 'package:junkee/login.dart'; // Import your signup screen here

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    Timer(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
      // After 5 seconds, navigate to the signup screen
      Timer(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SignupScreen(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image or color
          Container(
            decoration: BoxDecoration(
              color: Color(0xfffcf8db), // Set your desired background color
            ),
          ),
          Center(
            child: Image.asset(
              "assets/mywayicon.png", // Set your image path here
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.6,
              // Adjust image size as needed
            ),
          ),
        ],
      ),
    );
  }
}
