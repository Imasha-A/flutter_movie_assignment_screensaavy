import 'package:flutter/material.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/home_screen.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/watched_list.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/watchlist.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(color: Colors.red),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            child: const Icon(
              Icons.home,
              size: 35,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WatchedList()));
            },
            child: const Icon(
              Icons.check_box,
              size: 35,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Watchlist()));
            },
            child: const Icon(
              Icons.bookmark,
              size: 35,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
