import 'package:flutter_movie_assignment_screensaavy/movie_information.dart';
import 'package:flutter_movie_assignment_screensaavy/tv_show_information.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  static const apiKey = '1261df0272d79d11053911503ae5753f';

  static const cinemaURL =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey';

  static const airingTodayURL =
      'https://api.themoviedb.org/3/tv/airing_today?api_key=$apiKey';

  static const animatedMoviesURL =
      'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_genres=16&api_key=$apiKey';

  static const topRatedMoviesURL =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';

  static const mostPopularMoviesURL =
      'https://api.themoviedb.org/3/discover/movie?primary_release_year=2023&sort_by=popularity.desc&api_key=$apiKey';

  static const imagePath = 'https://image.tmdb.org/t/p/w500';

  Future<List<MovieInformation>> getCinema() async {
    final cinemaResponse = await http.get(Uri.parse(cinemaURL));
    if (cinemaResponse.statusCode == 200) {
      final cinemaDecodedData =
          json.decode(cinemaResponse.body)["results"] as List;
      return cinemaDecodedData
          .map((movie) => MovieInformation.fromJson(movie))
          .toList();
    } else {
      throw Exception("Error");
    }
  }

  Future<List<TvShowInformation>> getTVTonight() async {
    final tvResponse = await http.get(Uri.parse(airingTodayURL));
    if (tvResponse.statusCode == 200) {
      final tvDecodedData = json.decode(tvResponse.body)["results"] as List;
      return tvDecodedData
          .map((tvShow) => TvShowInformation.fromJson(tvShow))
          .toList();
    } else {
      throw Exception("Error");
    }
  }

  Future<List<MovieInformation>> getAnimatedMovies() async {
    final animationResponse = await http.get(Uri.parse(animatedMoviesURL));
    if (animationResponse.statusCode == 200) {
      final animationDecodedData =
          json.decode(animationResponse.body)["results"] as List;
      return animationDecodedData
          .map((movie) => MovieInformation.fromJson(movie))
          .toList();
    } else {
      throw Exception("Error");
    }
  }

  Future<List<MovieInformation>> getTopRated() async {
    final topRatedResponse = await http.get(Uri.parse(topRatedMoviesURL));
    if (topRatedResponse.statusCode == 200) {
      final topRatedDecodedData =
          json.decode(topRatedResponse.body)["results"] as List;
      return topRatedDecodedData
          .map((movie) => MovieInformation.fromJson(movie))
          .toList();
    } else {
      throw Exception("Error");
    }
  }

  Future<List<MovieInformation>> getMostPopularMovies() async {
    final popularResponse = await http.get(Uri.parse(mostPopularMoviesURL));
    if (popularResponse.statusCode == 200) {
      final popularDecodedData =
          json.decode(popularResponse.body)["results"] as List;
      return popularDecodedData
          .map((movie) => MovieInformation.fromJson(movie))
          .toList();
    } else {
      throw Exception("Error");
    }
  }
}
