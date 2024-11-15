import 'dart:convert';

import 'package:data_movie_project/data/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String favoritesKey = 'favoriteMoviesList';

  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  Future<void> addFavoriteMovie(Movie movie) async {
    final List<String> favorites = _prefs.getStringList(favoritesKey) ?? [];
    favorites.add(jsonEncode(movie.toJson()));
    await _prefs.setStringList(favoritesKey, favorites);
  }

  Future<void> removeFavoriteMovie(Movie movie) async {
    final List<String> favorites = _prefs.getStringList(favoritesKey) ?? [];
    if (favorites.isNotEmpty) {
      favorites.removeWhere((item) {
        try {
          final decodedItem = jsonDecode(item);

          if (decodedItem is Map<String, dynamic> &&
              decodedItem['id'] != null) {
            return decodedItem['id'] == movie.id;
          }
        } catch (e) {
          print("Erro ao decodificar o item: $e");
        }
        return false;
      });
    }
    await _prefs.setStringList(favoritesKey, favorites);
  }

  Future<List<Movie>> getFavoriteMovies() async {
    final jsonMovies = _prefs.getStringList(favoritesKey);
    if (jsonMovies == null || jsonMovies.isEmpty) {
      return [];
    }

    return jsonMovies
        .map((jsonMovie) {
          try {
            final decodedMovie = jsonDecode(jsonMovie);
            print("Filme decodificado: $decodedMovie");

            if (decodedMovie != null && decodedMovie is Map<String, dynamic>) {
              return Movie.fromJson(decodedMovie);
            } else {
              print("O filme decodificado não é um Map válido.");
              return null;
            }
          } catch (e) {
            print("Erro ao decodificar o filme: $e");
            return null;
          }
        })
        .where((movie) => movie != null)
        .cast<Movie>()
        .toList();
  }
}

extension on Movie {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'posterUrl': posterUrl,
      'rating': rating,
    };
  }
}
