import 'package:data_movie_project/data/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../viewmodels/movie_list_viewmodel.dart';
import '../../presentation/widgets/movie_card.dart';
import '../../presentation/screens/favorite_list_screen.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final movieListViewModel =
          Provider.of<MovieListViewModel>(context, listen: false);
      movieListViewModel.fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteListScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<MovieListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.movies.isEmpty) {
            return const Center(child: Text('No movies found.'));
          }
          return ListView.builder(
            itemCount: viewModel.movies.length,
            itemBuilder: (context, index) {
              final movie = viewModel.movies[index];
              return MovieCard(movie: movie);
            },
          );
        },
      ),
    );
  }
}
