import 'package:data_movie_project/data/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../presentation/widgets/favorite_card.dart';
import '../../data/models/movie_model.dart';

class FavoriteListScreen extends StatefulWidget {
  const FavoriteListScreen({super.key});

  @override
  _FavoriteListScreenState createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  List<Movie> favoriteMovies = [];
  late LocalStorageService localStorageService;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _initializeLocalStorage();
      await loadFavoriteMovies();
    });
  }

  Future<void> _initializeLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    localStorageService = LocalStorageService(prefs);
  }

  Future<void> loadFavoriteMovies() async {
    final movies = await localStorageService.getFavoriteMovies();

    setState(() {
      favoriteMovies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: favoriteMovies.isEmpty
          ? const Center(child: Text('No favorite movies found.'))
          : ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];
                return FavoriteCard(movie: movie);
              },
            ),
    );
  }
}
