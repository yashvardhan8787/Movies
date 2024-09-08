import "package:flutter/material.dart";

class MovieCarouselItem extends StatelessWidget {
  final dynamic movie;

  const MovieCarouselItem({required this.movie, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.network(
            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          movie.title.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),
        Text(
          movie.overview.toString(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}