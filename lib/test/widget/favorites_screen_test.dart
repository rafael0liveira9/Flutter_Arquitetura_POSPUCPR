import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:data_movie_project/data/models/movie_model.dart';
import 'package:data_movie_project/presentation/screens/favorite_list_screen.dart';
import 'package:data_movie_project/data/services/local_storage_service.dart';
import 'package:data_movie_project/presentation/widgets/favorite_card.dart';

class FakeLocalStorageService implements LocalStorageService {
  final List<Movie> favoriteMovies;

  FakeLocalStorageService({required this.favoriteMovies});

  @override
  Future<List<Movie>> getFavoriteMovies() async {
    return Future.value(favoriteMovies);
  }

  @override
  Future<void> addFavoriteMovie(Movie movie) async {
    throw UnimplementedError();
  }

  @override
  Future<void> removeFavoriteMovie(Movie movie) async {
    throw UnimplementedError();
  }
}

void main() {
  Widget createWidgetUnderTest({required FakeLocalStorageService service}) {
    return Provider<LocalStorageService>.value(
      value: service,
      child: const MaterialApp(
        home: FavoriteListScreen(),
      ),
    );
  }

  group('FavoriteListScreen Tests', () {
    late FakeLocalStorageService fakeService;

    setUp(() {
      fakeService = FakeLocalStorageService(favoriteMovies: []);
    });

    testWidgets('Exibe o AppBar com título Favoritos',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(service: fakeService));

      expect(find.text('Favoritos'), findsOneWidget);
    });

    testWidgets(
        'Exibe mensagem "No favorite movies found." quando não há filmes favoritos',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(service: fakeService));
      await tester.pumpAndSettle();

      expect(find.text('No favorite movies found.'), findsOneWidget);
    });

    print('Tes Favorite Screen: Ok');
  });
}
