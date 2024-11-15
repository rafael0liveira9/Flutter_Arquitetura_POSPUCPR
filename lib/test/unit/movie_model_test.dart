import 'package:flutter_test/flutter_test.dart';
import '../../data/models/movie_model.dart';

void main() {
  group('Movie Model', () {
    tearDown(() {
      print('TEST MODEL: Success');
    });

    test('Deve criar uma instância de Movie a partir de JSON válido', () {
      final json = {
        'id': 123,
        'title': 'Test Movie',
        'overview': 'This is a test overview',
        'poster_path': '/testPoster.jpg',
        'vote_average': 8.5
      };

      final movie = Movie.fromJson(json);

      expect(movie.id, '123');
      expect(movie.title, 'Test Movie');
      expect(movie.overview, 'This is a test overview');
      expect(movie.posterUrl, 'https://image.tmdb.org/t/p/w500/testPoster.jpg');
      expect(movie.rating, 8.5);
    });

    test('Deve lidar com JSON ausente de poster_path e vote_average', () {
      final json = {
        'id': 456,
        'title': 'Test Movie without Poster and Rating',
        'overview': 'Overview for movie without poster and rating',
      };

      final movie = Movie.fromJson(json);

      expect(movie.id, '456');
      expect(movie.title, 'Test Movie without Poster and Rating');
      expect(movie.overview, 'Overview for movie without poster and rating');
      expect(movie.posterUrl, '');
      expect(movie.rating, 0);
    });

    test('Deve lidar com valores inválidos de rating e definir como 0', () {
      final json = {
        'id': 789,
        'title': 'Invalid Rating Movie',
        'overview': 'This movie has an invalid rating',
        'vote_average': 'invalid_rating'
      };

      final movie = Movie.fromJson(json);

      expect(movie.id, '789');
      expect(movie.title, 'Invalid Rating Movie');
      expect(movie.overview, 'This movie has an invalid rating');
      expect(movie.rating, 0);
    });
  });
}
