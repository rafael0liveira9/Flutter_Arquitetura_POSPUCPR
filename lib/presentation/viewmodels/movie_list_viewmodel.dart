import 'package:flutter/material.dart';
import '../../data/models/movie_model.dart';
import '../../data/repositories/movie_repository.dart';

class MovieListViewModel extends ChangeNotifier {
  final MovieRepository movieRepository;
  List<Movie> _movies = [];
  bool _isLoading = false;

  MovieListViewModel({required this.movieRepository});

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;

  Future<void> fetchMovies() async {
    _setLoading(true);
    try {
      _movies = await movieRepository.getMovies();
    } catch (error) {
      print('Erro ao buscar filmes: $error');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
