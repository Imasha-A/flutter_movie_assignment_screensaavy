import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/login_screen.dart';
import 'package:flutter_movie_assignment_screensaavy/tv_show_information.dart';
import 'package:flutter_movie_assignment_screensaavy/screens/details_screen.dart';
import 'package:flutter_movie_assignment_screensaavy/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<TvShowInformation>> onTvTonight;
  @override
  void initState() {
    super.initState();
    onTvTonight = Api().getTVTonight();
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
              const MovieScrollWidget(),
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
              const MovieScrollWidget(),
              const SizedBox(height: 16),
              const Text('Best movies this year',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              const MovieScrollWidget(),
              const SizedBox(height: 16),
              const Text('Highest grossing movies of all time',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              const MovieScrollWidget(),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: const Text('Logout')),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieScrollWidget extends StatelessWidget {
  const MovieScrollWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: CarouselSlider.builder(
            itemCount: 25,
            itemBuilder: (context, index, realIndex) {
              return Container(height: 200, width: 200, color: Colors.red);
            },
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              viewportFraction: 0.5,
              enlargeCenterPage: true,
              autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
              autoPlayAnimationDuration: const Duration(seconds: 1),
            )));
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

class SearchByTitle extends StatefulWidget {
  const SearchByTitle({super.key});

  @override
  State<SearchByTitle> createState() => _SearchByTitleState();
}

class _SearchByTitleState extends State<SearchByTitle> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SearchByActor extends StatefulWidget {
  const SearchByActor({super.key});

  @override
  State<SearchByActor> createState() => _SearchByActorState();
}

class _SearchByActorState extends State<SearchByActor> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
