import 'package:flutter/material.dart';
import 'package:flutter_movie_assignment_screensaavy/api.dart';
import 'package:flutter_movie_assignment_screensaavy/custom_navigation_bar.dart';
import 'package:flutter_movie_assignment_screensaavy/movie_information.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/details_screen.dart';
import 'package:flutter_movie_assignment_screensaavy/tv_show_information.dart';
import 'package:flutter_movie_assignment_screensaavy/network_connectivity.dart';

class SearchByActor extends StatefulWidget {
  const SearchByActor({super.key});

  @override
  State<SearchByActor> createState() => _SearchByActorState();
}

class _SearchByActorState extends State<SearchByActor> {
  final Api api = Api();
  TextEditingController searchByActorController = TextEditingController();
  List<dynamic> searchByActorResults = [];

  Future<void> runByActorSearch(String query) async {
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
      List<dynamic> results = await api.searchByActor(query);
      setState(() {
        searchByActorResults = results;
      });
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search By Actor'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchByActorController,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white.withOpacity(0.3),
              decoration: InputDecoration(
                hintText: 'Search for a movie or TV show by actor name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    String query = searchByActorController.text.trim();
                    if (query.isNotEmpty) {
                      await runByActorSearch(query);
                    }
                  },
                ),
              ),
              onSubmitted: (String query) async {
                if (query.isNotEmpty) {
                  await runByActorSearch(query);
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: searchByActorResults.length,
              itemBuilder: (context, index) {
                var person = searchByActorResults[index];

                if (person['known_for_department'] != 'Acting') {
                  return Container();
                }

                int actorId = person['id'];
                String actorName = person['name'];
                String actorProfilePath = person['profile_path'] ?? '';

                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: actorProfilePath.isNotEmpty
                        ? NetworkImage('${Api.imagePath}$actorProfilePath')
                        : null,
                    child: actorProfilePath.isEmpty
                        ? const Center(
                            child: Text(
                              'No Image',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black),
                            ),
                          )
                        : null,
                  ),
                  title: Text(
                    'ID: $actorId',
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Name: $actorName',
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActorDetails(
                          actorId: actorId,
                          actorName: actorName,
                          actorProfilePath: actorProfilePath,
                          api: api,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}

class ActorDetails extends StatelessWidget {
  final int actorId;
  final String actorName;
  final String actorProfilePath;
  final Api api;

  const ActorDetails(
      {super.key,
      required this.actorId,
      required this.actorName,
      required this.actorProfilePath,
      required this.api});

  Future<List<Widget>> getMovieAndTvShowWidgets(BuildContext context) async {
    List<Widget> movieAndTvShowWidgets = [];

    try {
      List<dynamic> movies = await api.discoverMoviesByActor(actorId);

      for (var movie in movies) {
        String title = movie['title'] ?? '';
        String posterPath = movie['poster_path'] ?? '';
        String originalTitle = movie['original_title'] ?? '';
        String backdropPath = movie['backdrop_path'] ?? '';
        String overview = movie['overview'] ?? '';
        String releaseDate = movie['release_date'] ?? '';
        double popularity = movie['popularity'] ?? '';
        double voteAverage = movie['vote_average'] ?? '';

        movieAndTvShowWidgets.add(GestureDetector(
          onTap: () {
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
                    voteAverage: voteAverage,
                  ),
                ),
              ),
            );
          },
          child: Container(
            width: 150,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: BorderRadius.circular(8),
              image: posterPath.isNotEmpty
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('${Api.imagePath}$posterPath'))
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black.withOpacity(0.7),
                  child: Text(
                    title.isNotEmpty ? title : '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (posterPath.isEmpty)
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'No Image Available',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
              ],
            ),
          ),
        ));
      }

      List<dynamic> tvShows = await api.discoverTvShowsByActor(actorId);

      for (var tvShow in tvShows) {
        String name = tvShow['name'] ?? '';
        String posterPath = tvShow['poster_path'] ?? '';
        String originalName = tvShow['original_name'] ?? '';
        String backdropPath = tvShow['backdrop_path'] ?? '';
        String overview = tvShow['overview'] ?? '';
        String firstAir = tvShow['first_air_date'] ?? '';
        double popularity = tvShow['popularity'] ?? '';
        double voteAverage = tvShow['vote_average'] ?? '';

        movieAndTvShowWidgets.add(GestureDetector(
          onTap: () {
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
                    voteAverage: voteAverage,
                  ),
                ),
              ),
            );
          },
          child: Container(
            width: 150,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: BorderRadius.circular(8),
              image: posterPath.isNotEmpty
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('${Api.imagePath}$posterPath'))
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black.withOpacity(0.7),
                  child: Text(
                    name.isNotEmpty ? name : '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (posterPath.isEmpty)
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'No Image Available',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
              ],
            ),
          ),
        ));
      }
    } catch (error) {
      print('Error getting movie and Tv show information: $error');
    }

    return movieAndTvShowWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 55,
            backgroundImage: actorProfilePath.isNotEmpty
                ? NetworkImage('${Api.imagePath}$actorProfilePath')
                : null,
            child: actorProfilePath.isEmpty
                ? const Center(
                    child: Text(
                      'No Image',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 20),
          Text('ID: $actorId',
              style: const TextStyle(fontSize: 18, color: Colors.white)),
          const SizedBox(height: 20),
          Text('Name: $actorName',
              style: const TextStyle(fontSize: 18, color: Colors.white)),
          const SizedBox(height: 20),
          FutureBuilder(
              future: getMovieAndTvShowWidgets(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Movies and TV shows',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) =>
                                  snapshot.data![index]),
                        )
                      ],
                    );
                  } else {
                    return const Text('No movies or TV shows available');
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              })
        ],
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}
