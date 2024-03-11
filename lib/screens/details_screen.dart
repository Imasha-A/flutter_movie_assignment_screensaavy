import 'package:flutter/material.dart';
import 'package:flutter_movie_assignment_screensaavy/movie_information.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/watched_list.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/watchlist.dart';
import 'package:flutter_movie_assignment_screensaavy/tv_show_information.dart';
import 'package:flutter_movie_assignment_screensaavy/api.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key, required this.movie});
  final MovieInformation movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          movie.title != null && movie.title!.isNotEmpty
              ? movie.title!
              : 'No title',
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  height: 500,
                  decoration: BoxDecoration(
                    image:
                        movie.posterPath != null && movie.posterPath!.isNotEmpty
                            ? DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                    '${Api.imagePath}${movie.posterPath}'),
                              )
                            : null,
                  ),
                  child: movie.posterPath != null && movie.posterPath!.isEmpty
                      ? const Center(
                          child: Text(
                            'No Image Available',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Overview:',
                  style: TextStyle(fontSize: 26.0, color: Colors.white),
                ),
                const SizedBox(height: 8.0),
                Text(
                  movie.overview != null && movie.overview!.isNotEmpty
                      ? movie.overview!
                      : 'No overview',
                  style: const TextStyle(fontSize: 26, color: Colors.white),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          const Text(
                            'Rating: ',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            '${(movie.voteAverage ?? 0.0) > 0 ? movie.voteAverage!.toStringAsFixed(1) : 'None'}/10',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            const Text(
                              'Release: ',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Text(
                              movie.releaseDate != null &&
                                      movie.releaseDate!.isNotEmpty
                                  ? movie.releaseDate!
                                  : 'None',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ],
                        )),
                  ],
                )),
                const SizedBox(height: 8.0),
                SizedBox(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            WatchedListData.watchedListMovies.add(movie);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Row(
                              children: [
                                Text(
                                  'Add to watched ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Icon(
                                  Icons.check_box,
                                  size: 30,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            WatchlistData.watchlistMovies.add(movie);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Row(
                              children: [
                                Text(
                                  'Add to watchlist ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Icon(
                                  Icons.bookmark,
                                  size: 30,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TvShowDetails extends StatelessWidget {
  const TvShowDetails({super.key, required this.tvShow});
  final TvShowInformation tvShow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          tvShow.name != null && tvShow.name!.isNotEmpty
              ? tvShow.name!
              : 'No title',
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  height: 500,
                  decoration: BoxDecoration(
                    image: tvShow.posterPath != null &&
                            tvShow.posterPath!.isNotEmpty
                        ? DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(
                                '${Api.imagePath}${tvShow.posterPath}'),
                          )
                        : null,
                  ),
                  child: tvShow.posterPath != null && tvShow.posterPath!.isEmpty
                      ? const Center(
                          child: Text(
                            'No Image Available',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Overview:',
                  style: TextStyle(fontSize: 26.0, color: Colors.white),
                ),
                const SizedBox(height: 8.0),
                Text(
                  tvShow.overview != null && tvShow.overview!.isNotEmpty
                      ? tvShow.overview!
                      : 'No overview',
                  style: const TextStyle(fontSize: 26, color: Colors.white),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          const Text(
                            'Rating: ',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            '${(tvShow.voteAverage ?? 0.0) > 0 ? tvShow.voteAverage!.toStringAsFixed(1) : 'None'}/10',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            const Text(
                              'First Air: ',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Text(
                              tvShow.firstAir != null &&
                                      tvShow.firstAir!.isNotEmpty
                                  ? tvShow.firstAir!
                                  : 'None',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ],
                        )),
                  ],
                )),
                const SizedBox(height: 8.0),
                SizedBox(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            WatchedListData.watchedListTvShows.add(tvShow);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Row(
                              children: [
                                Text(
                                  'Add to watched ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Icon(
                                  Icons.check_box,
                                  size: 30,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            WatchlistData.watchlistTvShows.add(tvShow);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Row(
                              children: [
                                Text(
                                  'Add to watchlist ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Icon(
                                  Icons.bookmark,
                                  size: 30,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
