import 'package:flutter/material.dart';
import 'package:flutter_movie_assignment_screensaavy/tv_show_information.dart';
import 'package:flutter_movie_assignment_screensaavy/api.dart';

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
          tvShow.name ?? 'No title',
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
                Image.network('${Api.imagePath}${tvShow.posterPath}',
                    filterQuality: FilterQuality.high, fit: BoxFit.fill),
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
                  style: TextStyle(
                      fontSize:
                          tvShow.overview != null && tvShow.overview!.isNotEmpty
                              ? 26
                              : 26,
                      color: Colors.white),
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
                            '${tvShow.voteAverage.toStringAsFixed(1)}/10',
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
                              tvShow.firstAir ?? 'No first air details',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ],
                        )),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
