import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_assignment_screensaavy/firebase_options.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/login_screen.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/watched_list.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/watchlist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //intializing firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await WatchlistData.loadData(); //loading any locally stored watchlist data
  await WatchedListData
      .loadData(); //loading any locally stored watched list data
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Assignment',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.red),
          ),
          scaffoldBackgroundColor: Colors.black),
      home: const LoginScreen(), //runs application starting from login screen
    );
  }
}
