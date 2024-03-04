import 'package:flutter/material.dart';
import 'package:flutter_movie_assignment_screensaavy/custom_navigation_bar.dart';

class WatchedList extends StatelessWidget {
  const WatchedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Image.asset('images/ScreenSaavyLogo.png',
            fit: BoxFit.cover, height: 50),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              Text('Your watched list',
                  style: TextStyle(fontSize: 23, color: Colors.white),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}
