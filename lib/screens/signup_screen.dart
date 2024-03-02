import 'package:flutter/material.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/home_screen.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent, title: const Text("Sign Up")),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: <Widget>[
                logoSetup('images/ScreenSaavyLogo.png'),
                const SizedBox(
                  height: 30,
                ),
                inputText('Enter Username', Icons.person_outline, false,
                    userNameTextController),
                const SizedBox(
                  height: 30,
                ),
                inputText('Enter Email', Icons.email_outlined, false,
                    emailTextController),
                const SizedBox(
                  height: 30,
                ),
                inputText('Enter Password', Icons.lock_outline, true,
                    passwordTextController),
                const SizedBox(
                  height: 30,
                ),
                buttonFormat('Sign up', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                }),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
