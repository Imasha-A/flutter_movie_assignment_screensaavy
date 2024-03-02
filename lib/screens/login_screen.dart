import 'package:flutter/material.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/home_screen.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                inputText('Enter Password', Icons.lock_outline, true,
                    passwordTextController),
                const SizedBox(
                  height: 30,
                ),
                buttonFormat('Login', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                }),
                const SizedBox(
                  height: 50,
                ),
                signUpOption(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Image logoSetup(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 250,
    height: 250,
  );
}

TextField inputText(String text, IconData icon, bool isPassword,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    enableSuggestions: !isPassword,
    autocorrect: !isPassword,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(1)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(1)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.5),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType:
        isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}

Widget buttonFormat(String buttonText, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white;
            } else if (states.contains(MaterialState.disabled)) {
              return Colors.blueGrey;
            }
            return Colors.red;
          },
        ),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 17),
      child: Text(
        buttonText,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

Column signUpOption(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Don't have an account?",
          style: TextStyle(color: Colors.white)),
      const SizedBox(height: 10),
      buttonFormat('SignUp', () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()));
      })
    ],
  );
}
