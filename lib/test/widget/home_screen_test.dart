import 'package:data_movie_project/data/services/api_service.dart';
import 'package:data_movie_project/presentation/viewmodels/movie_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:data_movie_project/presentation/screens/movie_list_screen.dart';
import 'package:data_movie_project/data/models/movie_model.dart';
import 'package:data_movie_project/data/repositories/movie_repository.dart';
import 'package:data_movie_project/presentation/widgets/movie_card.dart';

class FakeMovieRepository implements MovieRepository {
  final List<Movie> movies;

  FakeMovieRepository({required this.movies});

  @override
  Future<List<Movie>> getMovies() async {
    return Future.value(movies);
  }

  @override
  ApiService get apiService => throw UnimplementedError();
}

void main() {
  Widget createWidgetUnderTest({required MovieListViewModel viewModel}) {
    return ChangeNotifierProvider<MovieListViewModel>.value(
      value: viewModel,
      child: const MaterialApp(
        home: MovieListScreen(),
      ),
    );
  }

  group('MovieListScreen Tests', () {
    late MovieListViewModel viewModel;

    setUp(() {
      final fakeRepository = FakeMovieRepository(movies: []);
      viewModel = MovieListViewModel(movieRepository: fakeRepository);
    });

    testWidgets('Exibe o AppBar com título Filmes',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(viewModel: viewModel));

      expect(find.text('Filmes'), findsOneWidget);
    });

    testWidgets('Exibe mensagem "No movies found." quando não há filmes',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(viewModel: viewModel));
      await viewModel.fetchMovies();
      await tester.pumpAndSettle();

      expect(find.text('No movies found.'), findsOneWidget);
    });
    print('HOME PAGE Test: Ok');
  });
}
