import 'package:flutter/material.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Assignment',
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      home: const LoginScreen(),
    );
  }
}
