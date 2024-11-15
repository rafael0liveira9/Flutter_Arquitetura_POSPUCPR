import 'package:flutter/material.dart';
import '../../data/models/movie_model.dart';

class MovieDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)?.settings.arguments;

    if (movie is Movie) {
      return Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    movie.posterUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.error),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      movie.rating.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  movie.overview,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Movie Details'),
        ),
        body: Center(
          child: Text('No movie found'),
        ),
      );
    }
  }
}
