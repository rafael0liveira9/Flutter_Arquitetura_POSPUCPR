import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:data_movie_project/data/models/movie_model.dart';
import 'package:data_movie_project/presentation/screens/movie_detail_screen.dart';

void main() {
  final fakeMovie = Movie(
    id: '1',
    title: 'Fake Movie',
    overview: 'This is a fake movie overview for testing purposes.',
    rating: 4.5,
    posterUrl: 'https://via.placeholder.com/150',
  );

  Widget createWidgetUnderTest({required Movie movie}) {
    return MaterialApp(
      home: MovieDetailScreen(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => MovieDetailScreen(),
          settings: RouteSettings(arguments: movie),
        );
      },
    );
  }

  group('MovieDetailScreen Tests', () {
    testWidgets('Exibe mensagem "No movie found" quando não há filme',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MovieDetailScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No movie found'), findsOneWidget);
    });
  });
}
