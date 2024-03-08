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

  static const highestGrossingMoviesURL =
      'https://api.themoviedb.org/3/discover/movie?include_adult=false&sort_by=revenue.desc&api_key=$apiKey';

  static const mostPopularMoviesURL =
      'https://api.themoviedb.org/3/discover/movie?primary_release_year=2024&sort_by=popularity.desc&api_key=$apiKey';

  static const imagePath = 'https://image.tmdb.org/t/p/w500';

  var searchURL = 'https://api.themoviedb.org/3/search/multi?api_key=$apiKey';

  var searchByActorURL =
      'https://api.themoviedb.org/3/search/person?include_adult=false&api_key=$apiKey';

  var discoverMovieURL =
      'https://api.themoviedb.org/3/discover/movie?include_adult=false&api_key=$apiKey';

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

  Future<List<MovieInformation>> getHighestGrossing() async {
    final highestGrossingResponse =
        await http.get(Uri.parse(highestGrossingMoviesURL));
    if (highestGrossingResponse.statusCode == 200) {
      final highestGrossingDecodedData =
          json.decode(highestGrossingResponse.body)["results"] as List;
      return highestGrossingDecodedData
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

  Future<List<dynamic>> searchByTitle(String query) async {
    final titleSearchResponse =
        await http.get(Uri.parse('$searchURL&query=$query'));
    if (titleSearchResponse.statusCode == 200) {
      final titleSearchDecodedData =
          json.decode(titleSearchResponse.body)["results"] as List;
      final titleSearchFilteredData = titleSearchDecodedData.where((result) {
        return result['media_type'] == 'movie' || result['media_type'] == 'tv';
      }).toList();
      return titleSearchFilteredData;
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> searchByActor(String query) async {
    final actorSearchResponse =
        await http.get(Uri.parse('$searchByActorURL&query=$query'));
    if (actorSearchResponse.statusCode == 200) {
      final actorSearchDecodedData =
          json.decode(actorSearchResponse.body)["results"] as List;
      return actorSearchDecodedData;
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> discoverMoviesByActor(int actorID) async {
    final actorMovieResponse =
        await http.get(Uri.parse('$discoverMovieURL&with_people=$actorID'));
    if (actorMovieResponse.statusCode == 200) {
      final actorMovieDecodedData =
          json.decode(actorMovieResponse.body)["results"] as List;
      return actorMovieDecodedData;
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> discoverTvShowsByActor(int actorID) async {
    final actorTvResponse = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/person/$actorID/tv_credits?api_key=$apiKey&include_adult=false'));
    if (actorTvResponse.statusCode == 200) {
      final actorTvDecodedData =
          json.decode(actorTvResponse.body)["cast"] as List;
      return actorTvDecodedData;
    } else {
      throw Exception("Error");
    }
  }
}
