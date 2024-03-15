import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie_assignment_screensaavy/api.dart';
import 'package:flutter_movie_assignment_screensaavy/custom_navigation_bar.dart';
import 'package:flutter_movie_assignment_screensaavy/movie_information.dart';
import 'package:flutter_movie_assignment_screensaavy/tv_show_information.dart';
import 'package:shared_preferences/shared_preferences.dart';

//class to hold the watchlist data from both movies and tv shows
class WatchlistData {
  static List<MovieInformation> watchlistMovies = [];
  static List<TvShowInformation> watchlistTvShows = [];

  static const String movieKey = 'watchlistMovies';
  static const String tvShowKey = 'watchlistTvShows';

  //class to save data to local storage using shared preferences
  static Future<void> saveData() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      //encoding movie list into json and saving to shared preferences
      final List<String> movieJsonList =
          watchlistMovies.map((movie) => json.encode(movie.toJson())).toList();
      //encoding tv show list into json and saving to shared preferences
      final List<String> tvShowJsonList = watchlistTvShows
          .map((tvShow) => json.encode(tvShow.toJson()))
          .toList();
      await preferences.setStringList(movieKey, movieJsonList);
      await preferences.setStringList(tvShowKey, tvShowJsonList);
      print('Data successfully saved to shared preferences');
    } catch (error) {
      print('Error saving data to shared preferences: $error');
    }
  }

  //class to load data from local storage using shared preferences
  static Future<void> loadData() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      //retrieving movie and tv show lists json from shared preferences
      final List<String>? movieJsonList = preferences.getStringList(movieKey);
      final List<String>? tvShowJsonList = preferences.getStringList(tvShowKey);

      if (movieJsonList != null) {
        watchlistMovies = movieJsonList
            .map((jsonString) =>
                MovieInformation.fromJson(json.decode(jsonString)))
            .toList();
      }

      if (tvShowJsonList != null) {
        watchlistTvShows = tvShowJsonList
            .map((jsonString) =>
                TvShowInformation.fromJson(json.decode(jsonString)))
            .toList();
      }

      print('Data successfully loaded from shared preferences');
    } catch (error) {
      print('Error loading data from shared preferences: $error');
    }
  }
}

//class to get movie and tv show watchlist and display them in a scrollable column format
class Watchlist extends StatelessWidget {
  const Watchlist({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              const Text('Your watchlist',
                  style: TextStyle(fontSize: 23, color: Colors.white),
                  textAlign: TextAlign.center),
              const SizedBox(height: 8),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: WatchlistData.watchlistMovies.length,
                itemBuilder: (BuildContext context, index) {
                  MovieInformation movie = WatchlistData.watchlistMovies[index];
                  return Container(
                    color: Colors.red[900],
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 16),
                        Container(
                          width: 150,
                          height: 300,
                          decoration: BoxDecoration(
                            image: movie.posterPath!.isNotEmpty
                                ? DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(
                                      '${Api.imagePath}${movie.posterPath}',
                                    ),
                                  )
                                : null,
                          ),
                          child: movie.posterPath!.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No image available',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 50),
                              Text(
                                movie.title ?? '',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: WatchlistData.watchlistTvShows.length,
                itemBuilder: (BuildContext context, index) {
                  TvShowInformation tvShow =
                      WatchlistData.watchlistTvShows[index];
                  return Container(
                    color: Colors.red[900],
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 16),
                        Container(
                          width: 150,
                          height: 300,
                          decoration: BoxDecoration(
                            image: tvShow.posterPath!.isNotEmpty
                                ? DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(
                                      '${Api.imagePath}${tvShow.posterPath}',
                                    ),
                                  )
                                : null,
                          ),
                          child: tvShow.posterPath!.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No image available',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 50),
                              Text(
                                tvShow.name ?? '',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}
