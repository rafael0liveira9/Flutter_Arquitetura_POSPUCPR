import 'package:get_it/get_it.dart';
import '../../data/repositories/movie_repository.dart';
import '../../data/services/api_service.dart';
import '../../presentation/viewmodels/movie_list_viewmodel.dart';

final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerLazySingleton<ApiService>(() => ApiService());
  }

  if (!getIt.isRegistered<MovieRepository>()) {
    getIt.registerLazySingleton<MovieRepository>(
      () => MovieRepository(apiService: getIt<ApiService>()),
    );
  }

  if (!getIt.isRegistered<MovieListViewModel>()) {
    getIt.registerFactory<MovieListViewModel>(
      () => MovieListViewModel(movieRepository: getIt<MovieRepository>()),
    );
  }
}
