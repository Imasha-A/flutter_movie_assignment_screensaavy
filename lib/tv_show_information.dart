//class for tvshow information
class TvShowInformation {
  String? backdropPath;
  String? originalName;
  String? overview;
  double popularity;
  String? posterPath;
  String? firstAir;
  String? name;
  double? voteAverage;

  TvShowInformation(
      {required this.backdropPath,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.firstAir,
      required this.name,
      required this.voteAverage});

  Map<String, dynamic> toJson() {
    return {
      "backdrop_path": backdropPath,
      "original_name": originalName,
      "overview": overview,
      "popularity": popularity,
      "poster_path": posterPath,
      "first_air_date": firstAir,
      "name": name,
      "vote_average": voteAverage,
    };
  }

  factory TvShowInformation.fromJson(Map<String, dynamic> json) {
    return TvShowInformation(
      backdropPath: json["backdrop_path"],
      originalName: json["original_name"],
      overview: json["overview"],
      popularity: json["popularity"],
      posterPath: json["poster_path"],
      firstAir: json["first_air_date"],
      name: json["name"],
      voteAverage: json["vote_average"],
    );
  }
}
