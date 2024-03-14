//class for movie information
class MovieInformation {
  String? title;
  String? originalTitle;
  String? backdropPath;
  String? overview;
  String? releaseDate;
  String? posterPath;
  double popularity;
  double? voteAverage;

  MovieInformation(
      {required this.title,
      required this.originalTitle,
      required this.backdropPath,
      required this.overview,
      required this.releaseDate,
      required this.posterPath,
      required this.popularity,
      required this.voteAverage});

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "original_title": originalTitle,
      "backdrop_path": backdropPath,
      "overview": overview,
      "release_date": releaseDate,
      "poster_path": posterPath,
      "popularity": popularity,
      "vote_average": voteAverage,
    };
  }

  factory MovieInformation.fromJson(Map<String, dynamic> json) {
    return MovieInformation(
      title: json["title"],
      originalTitle: json["original_title"],
      backdropPath: json["backdrop_path"],
      overview: json["overview"],
      releaseDate: json["release_date"],
      posterPath: json["poster_path"],
      popularity: json["popularity"],
      voteAverage: json["vote_average"],
    );
  }
}
