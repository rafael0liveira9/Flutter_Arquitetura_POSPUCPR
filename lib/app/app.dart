import 'package:flutter/material.dart';
import 'app_router.dart';
import '../presentation/themes/app_theme.dart';
import 'package:provider/provider.dart';
import '../core/di/dependency_injection.dart';
import '../presentation/viewmodels/movie_list_viewmodel.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setupDependencyInjection();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<MovieListViewModel>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie App',
        theme: AppTheme.theme,
        initialRoute: '/',
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
