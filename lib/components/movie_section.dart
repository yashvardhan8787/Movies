import 'package:flutter/material.dart';
import 'package:movies/components/listview_shimmer.dart';
import 'package:movies/model/fetch_movies_model.dart';
import '../services/fetch_movies.dart';
import '../view/detail_page_view.dart';

class MovieSection extends StatefulWidget {
  final String sectionName;
  final String sectionEndpoint;

  const MovieSection({super.key, required this.sectionName, required this.sectionEndpoint});

  @override
  State<MovieSection> createState() => _MovieSectionState();
}

class _MovieSectionState extends State<MovieSection> {
  Future<FetchMoviesModel?>? moviesData;

  @override
  void initState() {
    super.initState();
    // Initialize the moviesData inside initState where widget properties are accessible
    moviesData = FetchMovies().fetchMoviesApi("2023-01-01", "2023-01-31", widget.sectionEndpoint);
  }


  @override
  Widget build(BuildContext context) {
    // Fetch screen size using MediaQuery
    final screenSize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // Consistent padding
          child: Text(
            widget.sectionName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder<FetchMoviesModel?>(
          future: moviesData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const  SizedBox(
                  height: 200, // Set the height of the horizontal list
                  child: ListviewShimmer());
            } else if (snapshot.hasError) {
              return const  SizedBox(
                  height: 200, // Set the height of the horizontal list
                  child: ListviewShimmer()); // Handle error
            } else if (!snapshot.hasData || snapshot.data!.results == null || snapshot.data!.results!.isEmpty) {
              return const  SizedBox(
                  height: 200, // Set the height of the horizontal list
                  child: ListviewShimmer());
            }

            return SizedBox(
              height: screenSize.height * 0.28, // Adjust height for movie cards based on screen size
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.results!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      final movieData = snapshot.data!.results![index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailPageView(movieData: movieData)),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0), // Horizontal padding between items
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align texts to start
                        children: [
                          Container(
                            width: screenSize.width * 0.35, // Responsive width for the movie poster
                            height: screenSize.height * 0.22, // Responsive height for the movie poster
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0), // Rounded corners for the card
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0), // Apply same border radius to image
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${snapshot.data!.results![index].posterPath.toString()}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4), // Spacing between image and title
                          Container(
                            width: screenSize.width * 0.30, // Adjust text width to avoid overflow
                            child: Text(
                              snapshot.data!.results![index].title.toString(),
                              overflow: TextOverflow.ellipsis, // Handle long titles
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1, // Limit title to one line
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
