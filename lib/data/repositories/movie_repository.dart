import '../models/movie_model.dart';
import '../services/api_service.dart';

class MovieRepository {
  final ApiService apiService;

  MovieRepository({required this.apiService});

  Future<List<Movie>> getMovies() async {
    try {
      final response = await apiService.getMovies();

      if (response != null && response.isNotEmpty) {
        return response.map((movieData) => Movie.fromJson(movieData)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Erro ao buscar filmes: $e');
      return [];
    }
  }
}
