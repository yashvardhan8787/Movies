import 'package:flutter/material.dart';
import 'package:movies/view_model/movie_cast_view_model.dart';
import 'package:provider/provider.dart';
import '../view_model/watchlist_view_model.dart';
 // Import your ViewModel

class MovieCast extends StatefulWidget {
  final dynamic movieData;

  const MovieCast({super.key, required this.movieData});

  @override
  State<MovieCast> createState() => _MovieCastState();
}

class _MovieCastState extends State<MovieCast> {
  @override
  void initState() {
    super.initState();
    // Fetch movie credits when the widget initializes
    // Using the MovieCastViewModel through Provider
    Future.microtask(() {
      final provider = Provider.of<MovieCastViewModel>(context, listen: false);
      provider.getMovieCredits(widget.movieData.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieCastViewModel>(
      builder: (context, value, child) {
        // Handle loading state
        if (value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Handle error or no data
        if (value.credits == null) {
          return const Center(child: Text('No credits available or failed to load'));
        }

        final credits = value.credits!;

        return Column(
          children: [
            // Display cast if available
            if (credits['cast'] != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cast',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: credits['cast'].length,
                        itemBuilder: (context, index) {
                          final cast = credits['cast'][index];
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: MediaQuery.of(context).size.height * 0.04,
                                  backgroundImage: cast['profile_path'] != null
                                      ? NetworkImage("https://image.tmdb.org/t/p/w200${cast['profile_path']}")
                                      : null,
                                  child: cast['profile_path'] == null
                                      ? const Icon(Icons.person, size: 40)
                                      : null,
                                ),
                                Text(
                                  cast['name'],
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  cast['character'],
                                  style: const TextStyle(color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

            // Display crew if available
            if (credits['crew'] != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Crew',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: credits['crew'].length,
                        itemBuilder: (context, index) {
                          final crew = credits['crew'][index];
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: MediaQuery.of(context).size.height * 0.04,
                                  backgroundImage: crew['profile_path'] != null
                                      ? NetworkImage("https://image.tmdb.org/t/p/w200${crew['profile_path']}")
                                      : null,
                                  child: crew['profile_path'] == null
                                      ? const Icon(Icons.person, size: 40)
                                      : null,
                                ),
                                Text(
                                  crew['name'],
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  crew['job'],
                                  style: const TextStyle(color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}


