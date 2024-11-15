import 'package:flutter/material.dart';
import '../presentation/screens/movie_list_screen.dart';
import '../presentation/screens/movie_detail_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MovieListScreen());
      case '/movieDetail':
        return MaterialPageRoute(builder: (_) => MovieDetailScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Página não encontrada!'),
        ),
      ),
    );
  }
}
