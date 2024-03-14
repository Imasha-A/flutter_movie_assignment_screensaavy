import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_assignment_screensaavy/firebase_options.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/login_screen.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/watched_list.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/watchlist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //intializing firebase
  await WatchlistData.loadData();
  await WatchedListData.loadData();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
