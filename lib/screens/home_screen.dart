import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_assignment_screensaavy/custom_navigation_bar.dart';
import 'package:flutter_movie_assignment_screensaavy/movie_information.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/login_screen.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/search_by_actor.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/search_by_title.dart';
import 'package:flutter_movie_assignment_screensaavy/tv_show_information.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/details_screen.dart';
import 'package:flutter_movie_assignment_screensaavy/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MovieInformation>> onCinema;
  late Future<List<TvShowInformation>> onTvTonight;
  late Future<List<MovieInformation>> kidsMovies;
  late Future<List<MovieInformation>> highestGrossingMovies;
  late Future<List<MovieInformation>> mostPopularMovies;

  @override
  void initState() {
    super.initState();
    onCinema = Api().getCinema();
    onTvTonight = Api().getTVTonight();
    kidsMovies = Api().getAnimatedMovies();
    highestGrossingMovies = Api().getHighestGrossing();
    mostPopularMovies = Api().getMostPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Image.asset('images/ScreenSaavyLogo.png',
            fit: BoxFit.cover, height: 50),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const Text('Find Movies and TV shows',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center),
              const SizedBox(height: 16),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchByTitle()));
                      },
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'By title name',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchByActor()));
                      },
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'By actor name',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text('Whats on at the cinema',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(
                child: FutureBuilder(
                  future: onCinema,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return MovieScrollWidget(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text('Whats on TV tonight',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(
                child: FutureBuilder(
                  future: onTvTonight,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return TvShowScrollWidget(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text('Children friendly movies',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(
                child: FutureBuilder(
                  future: kidsMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return MovieScrollWidget(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text('Best movies this year',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(
                child: FutureBuilder(
                  future: mostPopularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return MovieScrollWidget(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text('Highest grossing movies of all time',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(
                child: FutureBuilder(
                  future: highestGrossingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return MovieScrollWidget(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      print("Signed Out");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    });
                  },
                  child: const Text('Logout')),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}

class MovieScrollWidget extends StatelessWidget {
  const MovieScrollWidget({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: CarouselSlider.builder(
          itemCount: snapshot.data?.length ?? 0,
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            viewportFraction: 0.5,
            enlargeCenterPage: true,
            autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
            autoPlayAnimationDuration: const Duration(seconds: 1),
          ),
          itemBuilder: (context, index, realIndex) {
            final movieInformation = snapshot.data?[index];
            if (movieInformation != null &&
                movieInformation.posterPath != null) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              (MovieDetails(movie: snapshot.data[index]))));
                },
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.network(
                    '${Api.imagePath}${movieInformation.posterPath}',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              (MovieDetails(movie: snapshot.data[index]))));
                },
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Container(
                    color: Colors.grey,
                    child: const Center(
                      child: Text('Image not available',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}

class TvShowScrollWidget extends StatelessWidget {
  const TvShowScrollWidget({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: CarouselSlider.builder(
          itemCount: snapshot.data?.length ?? 0,
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            viewportFraction: 0.5,
            enlargeCenterPage: true,
            autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
            autoPlayAnimationDuration: const Duration(seconds: 1),
          ),
          itemBuilder: (context, index, realIndex) {
            final tvInformation = snapshot.data?[index];
            if (tvInformation != null && tvInformation.posterPath != null) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              (TvShowDetails(tvShow: snapshot.data[index]))));
                },
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.network(
                    '${Api.imagePath}${tvInformation.posterPath}',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              (TvShowDetails(tvShow: snapshot.data[index]))));
                },
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Container(
                    color: Colors.grey,
                    child: const Center(
                      child: Text('Image not available',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}
