import 'package:flutter_movie_assignment_screensaavy/tv_show_information.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  static const apiKey = '1261df0272d79d11053911503ae5753f';
  static const airingTodayURL =
      'https://api.themoviedb.org/3/tv/airing_today?api_key=$apiKey';

  static const imagePath = 'https://image.tmdb.org/t/p/w500';

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
}
