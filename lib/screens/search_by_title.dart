import 'package:flutter/material.dart';
import 'package:flutter_movie_assignment_screensaavy/api.dart';
import 'package:flutter_movie_assignment_screensaavy/custom_navigation_bar.dart';
import 'package:flutter_movie_assignment_screensaavy/movie_information.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/details_screen.dart';
import 'package:flutter_movie_assignment_screensaavy/tv_show_information.dart';
import 'package:flutter_movie_assignment_screensaavy/network_connectivity.dart';

class SearchByTitle extends StatefulWidget {
  const SearchByTitle({super.key});

  @override
  State<SearchByTitle> createState() => _SearchByTitleState();
}

class _SearchByTitleState extends State<SearchByTitle> {
  final Api api = Api();
  TextEditingController searchTitleController = TextEditingController();
  List<dynamic> searchTitleResults = [];
  String sortOrder = 'Ascending';

  Future<void> runTitleSearch(String query) async {
    bool isConnected = await checkInternetConnectivity();
    if (!isConnected) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No internet connectivity'),
        ));
      }
      return;
    }
    try {
      List<dynamic> results = await api.searchByTitle(query);
      setState(() {
        searchTitleResults = results;
        handleSortOrderChange(sortOrder);
      });
    } catch (error) {
      print("Error: $error");
    }
  }

  void handleSortOrderChange(String? value) {
    if (value != null) {
      setState(() {
        sortOrder = value;
        searchTitleResults.sort((a, b) {
          String titleA = a['title'] ?? '';
          String nameA = a['name'] ?? '';
          String titleB = b['title'] ?? '';
          String nameB = b['name'] ?? '';

          String aCombined = titleA.isNotEmpty ? titleA : nameA;
          String bCombined = titleB.isNotEmpty ? titleB : nameB;

          if (sortOrder == 'Ascending') {
            return aCombined.compareTo(bCombined);
          } else {
            return bCombined.compareTo(aCombined);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search By Title'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchTitleController,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white.withOpacity(0.3),
              decoration: InputDecoration(
                hintText: 'Search for a movie or TV show by the title',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    String query = searchTitleController.text.trim();
                    if (query.isNotEmpty) {
                      await runTitleSearch(query);
                    }
                  },
                ),
              ),
              onSubmitted: (String query) async {
                if (query.isNotEmpty) {
                  await runTitleSearch(query);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Sort by: ',
                  style: TextStyle(color: Colors.red),
                ),
                Container(
                  color: Colors.black,
                  child: DropdownButton<String>(
                    value: sortOrder,
                    onChanged: handleSortOrderChange,
                    items: const <DropdownMenuItem<String>>[
                      DropdownMenuItem(
                        value: 'Ascending',
                        child: Text(
                          'Ascending',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Descending',
                        child: Text(
                          'Descending',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: searchTitleResults.length,
                  itemBuilder: (context, index) {
                    String title = searchTitleResults[index]['title'] ?? '';
                    String name = searchTitleResults[index]['name'] ?? '';
                    String overview =
                        searchTitleResults[index]['overview'] ?? '';
                    String posterPath =
                        searchTitleResults[index]['poster_path'] ?? '';
                    String originalTitle =
                        searchTitleResults[index]['original_title'] ?? '';
                    String originalName =
                        searchTitleResults[index]['original_name'] ?? '';
                    String backdropPath =
                        searchTitleResults[index]['backdrop_path'] ?? '';
                    String releaseDate =
                        searchTitleResults[index]['release_date'] ?? '';
                    String firstAir =
                        searchTitleResults[index]['first_air_date'] ?? '';
                    double popularity =
                        searchTitleResults[index]['popularity'] ?? '';
                    double voteAverage =
                        searchTitleResults[index]['vote_average'] ?? '';

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (searchTitleResults[index]['media_type'] ==
                              'movie') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetails(
                                  movie: MovieInformation(
                                      title: title,
                                      originalTitle: originalTitle,
                                      backdropPath: backdropPath,
                                      overview: overview,
                                      releaseDate: releaseDate,
                                      popularity: popularity,
                                      posterPath: posterPath,
                                      voteAverage: voteAverage),
                                ),
                              ),
                            );
                          } else if (searchTitleResults[index]['media_type'] ==
                              'tv') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TvShowDetails(
                                  tvShow: TvShowInformation(
                                      name: name,
                                      originalName: originalName,
                                      backdropPath: backdropPath,
                                      overview: overview,
                                      firstAir: firstAir,
                                      popularity: popularity,
                                      posterPath: posterPath,
                                      voteAverage: voteAverage),
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          color: Colors.red[900],
                          margin: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 16),
                              Container(
                                width: 150,
                                height: 300,
                                decoration: BoxDecoration(
                                  image: posterPath.isNotEmpty
                                      ? DecorationImage(
                                          fit: BoxFit.contain,
                                          image: NetworkImage(
                                              '${Api.imagePath}$posterPath'),
                                        )
                                      : null,
                                ),
                                child: posterPath.isEmpty
                                    ? const Center(
                                        child: Text(
                                          'No Image Available',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 25),
                                      Text(
                                        title.isNotEmpty ? title : name,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}
