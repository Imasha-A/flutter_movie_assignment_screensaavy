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
